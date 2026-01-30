# MCP Integration Guide - Tool Usage Patterns

This guide provides detailed examples and patterns for using Canny, Zendesk, Gong, and Planhat MCP tools to collect customer feedback data.

## Overview

The customer feedback analysis skill integrates four MCP-connected data sources:

| Source | Provider | Primary Data | MCP Tools Available |
|--------|----------|--------------|---------------------|
| **Canny** | Feature request platform | Posts, votes, comments, scores | `get_boards`, `get_posts`, `get_post`, `search_posts` |
| **Zendesk** | Support ticket system | Tickets, priority, comments, customer info | `get_tickets`, `get_ticket`, `get_ticket_comments` |
| **Gong** | Call recording/transcription | Call transcripts, topics, sentiment | `list_calls`, `retrieve_transcripts` |
| **Planhat** | Customer success platform | Health scores, conversations, activities, customer data | `get_model_actions`, `get_model_action_parameters`, `perform_model_action` |

## Canny MCP Tools

### Tool: `mcp__canny__get_boards`

**Purpose:** List all available Canny boards to identify where feedback is collected.

**Parameters:** None

**Example call:**

```json
{
  "tool": "mcp__canny__get_boards"
}
```

**Example response:**

```json
{
  "boards": [
    {
      "id": "board_abc123",
      "name": "Feature Requests",
      "postCount": 342,
      "url": "https://feathr.canny.io/feature-requests"
    },
    {
      "id": "board_def456",
      "name": "Bug Reports",
      "postCount": 156,
      "url": "https://feathr.canny.io/bugs"
    },
    {
      "id": "board_ghi789",
      "name": "Fundraising Feedback",
      "postCount": 89,
      "url": "https://feathr.canny.io/fundraising"
    }
  ]
}
```

**Usage pattern:**
1. Call `get_boards` once at start of analysis
2. Identify relevant board IDs (typically "Feature Requests", product-specific boards)
3. Use board IDs in subsequent `get_posts` calls

**What to extract:**
- Board IDs for filtering
- Board names for categorization
- Post counts for volume estimates

---

### Tool: `mcp__canny__get_posts`

**Purpose:** Fetch posts from a specific board with optional filtering and sorting.

**Parameters:**
- `boardId` (required): ID of the board to fetch posts from
- `limit` (optional): Number of posts to retrieve (default: 10, max: 50)
- `skip` (optional): Number of posts to skip for pagination (default: 0)
- `sort` (optional): Sort order - "newest", "oldest", "relevance", "trending" (default: "trending")
- `status` (optional): Filter by status - "open", "under review", "planned", "in progress", "complete", "closed"
- `search` (optional): Search term to filter posts

**Example call - Full review mode:**

```json
{
  "tool": "mcp__canny__get_posts",
  "boardId": "board_abc123",
  "limit": 50,
  "sort": "trending",
  "status": "open"
}
```

**Example call - Incremental mode with date filtering:**

Note: Canny doesn't support direct date filtering in `get_posts`, so you'll need to:
1. Fetch posts sorted by "newest"
2. Filter by `created` or `updated` timestamp after receiving results

```json
{
  "tool": "mcp__canny__get_posts",
  "boardId": "board_abc123",
  "limit": 50,
  "sort": "newest"
}
```

Then filter results where `post.created > last_analysis_date` or `post.updated > last_analysis_date`.

**Example response:**

```json
{
  "posts": [
    {
      "id": "post_123",
      "title": "Flight-level email activity tables",
      "details": "We need to see email performance broken down by individual flights (sends), not just rolled up at the campaign level. This would help us understand which specific emails performed best.",
      "score": 45,
      "votes": 18,
      "commentCount": 7,
      "status": "open",
      "created": "2025-11-15T10:30:00Z",
      "updated": "2026-01-10T14:22:00Z",
      "author": {
        "name": "Jane Smith",
        "email": "jane@acmenonprofit.org"
      },
      "board": {
        "name": "Feature Requests"
      }
    }
  ]
}
```

**What to extract:**
- `title` - Feature request name
- `details` - Full description/context
- `votes` - Number of customers who want this (frequency)
- `score` - Canny's algorithmic ranking
- `created`/`updated` - Timestamps for recency calculation
- `author.name`, `author.email` - Customer info
- `commentCount` - Indicator of engagement

**Usage patterns:**

**Pattern 1: Fetch all high-priority posts**
```
1. get_posts(boardId, limit=50, sort="trending")
2. Filter for posts with votes ≥ 5 or score ≥ 30
3. Extract detailed info with get_post() if needed
```

**Pattern 2: Incremental fetch (new/updated since last run)**
```
1. get_posts(boardId, limit=50, sort="newest")
2. Filter where created > last_analysis_date OR updated > last_analysis_date
3. Stop when reaching posts older than last_analysis_date
```

**Pattern 3: Search for specific topics**
```
1. get_posts(boardId, search="email", limit=50)
2. Review results for relevance
3. Repeat with other keywords if needed
```

---

### Tool: `mcp__canny__get_post`

**Purpose:** Get detailed information about a specific post, including comments.

**Parameters:**
- `postId` (required): ID of the post to retrieve

**Example call:**

```json
{
  "tool": "mcp__canny__get_post",
  "postId": "post_123"
}
```

**Example response:**

```json
{
  "id": "post_123",
  "title": "Flight-level email activity tables",
  "details": "We need to see email performance...",
  "score": 45,
  "votes": 18,
  "status": "open",
  "created": "2025-11-15T10:30:00Z",
  "updated": "2026-01-10T14:22:00Z",
  "author": {
    "name": "Jane Smith",
    "email": "jane@acmenonprofit.org"
  },
  "comments": [
    {
      "id": "comment_789",
      "value": "This is critical for us. We currently have to export CSVs and manually analyze in Excel, which takes hours every week.",
      "created": "2025-11-20T09:15:00Z",
      "author": {
        "name": "Bob Johnson",
        "email": "bob@helpinghandsnpo.org"
      }
    },
    {
      "id": "comment_790",
      "value": "Yes! We've been asking for this since we started using Feathr. It's frustrating not to have this visibility.",
      "created": "2026-01-10T14:22:00Z",
      "author": {
        "name": "Sarah Lee",
        "email": "sarah@communityfirst.org"
      }
    }
  ]
}
```

**What to extract:**
- All data from `get_posts` response
- `comments` array for:
  - Additional context and use cases
  - Sentiment/urgency indicators ("critical", "frustrating")
  - Customer names/emails for frequency counting

**When to use:**
- High-vote posts (≥10 votes) that need detailed context
- Posts with many comments (≥5) that may contain urgency signals
- Posts where initial description is vague and comments provide clarity

---

### Tool: `mcp__canny__search_posts`

**Purpose:** Search for posts across boards by keyword.

**Parameters:**
- `query` (required): Search query
- `boardIds` (optional): Array of board IDs to limit search scope
- `limit` (optional): Number of posts to retrieve (default: 20, max: 50)
- `status` (optional): Filter by status

**Example call:**

```json
{
  "tool": "mcp__canny__search_posts",
  "query": "email reporting",
  "limit": 30,
  "status": "open"
}
```

**Usage pattern:**
- Use when looking for feedback on specific topics/features
- More targeted than fetching all posts and filtering
- Good for exploratory analysis or validating if a feature has been requested

---

### Vote Count Interpretation

**Each vote = 1 customer** who wants the feature.

In frequency calculations:
- Post with 18 votes = 18 mentions
- Don't double-count: If a customer votes AND comments, count them once (vote already includes them)

---

### Extracting Timestamps and Customer Info

**For recency scoring:**
- Use `created` field for when feature was first requested
- Use `updated` field for most recent activity (includes new comments/votes)
- For incremental mode, use `updated` to catch posts with new engagement

**For customer info:**
- `author.name`, `author.email` from post
- `author.name`, `author.email` from each comment
- Deduplicate across votes/comments (same email = same customer)

---

## Zendesk MCP Tools

### Tool: `mcp__zendesk__get_tickets`

**Purpose:** Fetch tickets with pagination and filtering support.

**Parameters:**
- `page` (optional): Page number (default: 1)
- `per_page` (optional): Tickets per page (default: 25, max: 100)
- `sort_by` (optional): Field to sort by - "created_at", "updated_at", "priority", "status" (default: "created_at")
- `sort_order` (optional): Sort order - "asc", "desc" (default: "desc")

**Example call - Full review mode:**

```json
{
  "tool": "mcp__zendesk__get_tickets",
  "per_page": 100,
  "sort_by": "created_at",
  "sort_order": "desc"
}
```

**Example call - Incremental mode:**

```json
{
  "tool": "mcp__zendesk__get_tickets",
  "per_page": 100,
  "sort_by": "updated_at",
  "sort_order": "desc"
}
```

Then filter results where `ticket.created_at > last_analysis_date` or `ticket.updated_at > last_analysis_date`.

**Example response:**

```json
{
  "tickets": [
    {
      "id": 12345,
      "subject": "Need flight-level email stats for reporting",
      "description": "Our team needs to see performance data for each individual email send (flight) within a campaign, not just the campaign totals. Currently we have to manually pull this from CSVs.",
      "status": "open",
      "priority": "high",
      "created_at": "2025-12-20T15:45:00Z",
      "updated_at": "2026-01-08T10:30:00Z",
      "requester_id": 67890,
      "assignee_id": 11111,
      "tags": ["feature-request", "email", "reporting"]
    }
  ],
  "next_page": 2,
  "previous_page": null,
  "count": 156
}
```

**What to extract:**
- `subject` - Summary of issue/request
- `description` - Full context
- `priority` - Maps to urgency score (urgent=100, high=75, normal=50, low=25)
- `status` - Filter for "open", "pending", "new" (not "solved", "closed")
- `created_at`/`updated_at` - Timestamps for recency
- `requester_id` - Customer identifier (use to get details with `get_ticket`)
- `tags` - May indicate feature requests vs. bugs

**Date filtering strategy:**

Zendesk doesn't support date parameters directly in `get_tickets`, so:

1. Fetch tickets sorted by `created_at` or `updated_at` DESC
2. Iterate through pages until timestamps fall outside your date range
3. Filter results in post-processing

**For full review (last 90 days):**
```python
target_date = today - 90 days
filtered_tickets = [t for t in tickets if t.created_at > target_date]
```

**For incremental (since last run):**
```python
last_run_date = read from previous analysis metadata
filtered_tickets = [t for t in tickets if t.updated_at > last_run_date]
```

---

### Tool: `mcp__zendesk__get_ticket`

**Purpose:** Retrieve detailed information about a specific ticket, including custom fields.

**Parameters:**
- `ticket_id` (required): The ID of the ticket to retrieve

**Example call:**

```json
{
  "tool": "mcp__zendesk__get_ticket",
  "ticket_id": 12345
}
```

**Example response:**

```json
{
  "ticket": {
    "id": 12345,
    "subject": "Need flight-level email stats",
    "description": "Full description...",
    "status": "open",
    "priority": "high",
    "created_at": "2025-12-20T15:45:00Z",
    "updated_at": "2026-01-08T10:30:00Z",
    "requester": {
      "id": 67890,
      "name": "Jane Smith",
      "email": "jane@acmenonprofit.org"
    },
    "organization": {
      "id": 99999,
      "name": "ACME Nonprofit"
    },
    "custom_fields": [
      {
        "id": 360012345678,
        "value": "Feature Request"
      },
      {
        "id": 360012345679,
        "value": "Email"
      }
    ]
  }
}
```

**What to extract:**
- `requester.name`, `requester.email` - Customer info for frequency/deduplication
- `organization.name` - Organization for ARR lookup (if available)
- `custom_fields` - May contain ARR, customer tier, product area

**When to use:**
- High-priority tickets (urgent/high) needing full context
- Tickets where you need customer/organization details for ARR data

---

### Tool: `mcp__zendesk__get_ticket_comments`

**Purpose:** Retrieve all comments for a ticket to understand full conversation context.

**Parameters:**
- `ticket_id` (required): The ID of the ticket

**Example call:**

```json
{
  "tool": "mcp__zendesk__get_ticket_comments",
  "ticket_id": 12345
}
```

**Example response:**

```json
{
  "comments": [
    {
      "id": 98765,
      "body": "We need to see performance data for each individual email send (flight) within a campaign, not just campaign totals.",
      "author_id": 67890,
      "created_at": "2025-12-20T15:45:00Z",
      "public": true
    },
    {
      "id": 98766,
      "body": "This is becoming urgent - our executive team is asking for these reports and we can't provide them.",
      "author_id": 67890,
      "created_at": "2026-01-08T10:30:00Z",
      "public": true
    },
    {
      "id": 98767,
      "body": "Thanks for the feedback. I've escalated this to our product team.",
      "author_id": 11111,
      "created_at": "2026-01-08T11:00:00Z",
      "public": true
    }
  ]
}
```

**What to extract:**
- Customer comments for:
  - Additional context and use cases
  - Urgency escalation ("becoming urgent", "executive team asking")
  - Frustration indicators
  - Workarounds they're using
- Support engineer comments for product team escalation notes

**When to use:**
- Tickets with multiple back-and-forth exchanges (comment_count ≥ 3)
- High-priority tickets where urgency may have escalated over time
- Tickets where initial description is brief and comments add context

---

### Priority Level Interpretation

Map Zendesk priority directly to urgency score:

| Priority | Urgency Score | Interpretation |
|----------|---------------|----------------|
| Urgent | 100 | Critical issue, immediate attention needed |
| High | 75 | Important issue, should be addressed soon |
| Normal | 50 | Standard issue, normal queue processing |
| Low | 25 | Minor issue, low priority |

---

### Identifying Feature Requests in Support Tickets

Not all Zendesk tickets are feature requests. Filter for:

**Include:**
- Tickets tagged "feature-request", "enhancement", "improvement"
- Tickets with "need", "want", "can we", "is there a way" language
- Tickets describing workflows that aren't currently supported
- Tickets asking "when will [feature] be available"

**Exclude:**
- Bug reports (unless they reveal missing functionality)
- How-to questions (unless they expose UX problems)
- Configuration/setup issues
- One-off technical problems

**Example filtering logic:**

```python
feature_request_indicators = [
    "feature request",
    "enhancement",
    "need",
    "want",
    "can we",
    "is there a way",
    "when will",
    "would be great if",
    "missing",
    "doesn't support"
]

def is_feature_request(ticket):
    # Check tags
    if "feature-request" in ticket.tags or "enhancement" in ticket.tags:
        return True

    # Check subject/description
    text = (ticket.subject + " " + ticket.description).lower()
    return any(indicator in text for indicator in feature_request_indicators)
```

---

## Gong MCP Tools

### Tool: `mcp__gong__list_calls`

**Purpose:** List calls with optional date range filtering.

**Parameters:**
- `fromDateTime` (optional): Start date/time in ISO format (e.g., "2025-10-01T00:00:00Z")
- `toDateTime` (optional): End date/time in ISO format (e.g., "2025-12-31T23:59:59Z")

**Example call - Full review mode (last 90 days):**

```json
{
  "tool": "mcp__gong__list_calls",
  "fromDateTime": "2025-10-18T00:00:00Z",
  "toDateTime": "2026-01-17T23:59:59Z"
}
```

**Example call - Incremental mode:**

```json
{
  "tool": "mcp__gong__list_calls",
  "fromDateTime": "2026-01-10T00:00:00Z",
  "toDateTime": "2026-01-17T23:59:59Z"
}
```

**Example response:**

```json
{
  "calls": [
    {
      "id": "call_abc123",
      "title": "Quarterly Business Review - ACME Nonprofit",
      "started": "2026-01-10T14:00:00Z",
      "duration": 3600,
      "participants": [
        {
          "name": "Jane Smith",
          "email": "jane@acmenonprofit.org",
          "role": "customer"
        },
        {
          "name": "Sarah Johnson",
          "email": "sarah@feathr.co",
          "role": "internal"
        }
      ],
      "topics": [
        "Email campaigns",
        "Reporting needs",
        "Feature requests"
      ]
    }
  ]
}
```

**What to extract:**
- `id` - Call ID for transcript retrieval
- `title` - Context about call type/customer
- `started` - Timestamp for recency
- `participants` - Customer names/emails
- `topics` - High-level themes (may indicate relevant calls)

**Usage pattern:**

1. `list_calls` with date range
2. Filter for customer-facing calls (exclude internal meetings)
3. Identify calls with relevant topics ("feature requests", "feedback", "product discussion")
4. Fetch transcripts for those calls with `retrieve_transcripts`

---

### Tool: `mcp__gong__retrieve_transcripts`

**Purpose:** Retrieve detailed transcripts for specified calls.

**Parameters:**
- `callIds` (required): Array of Gong call IDs

**Example call:**

```json
{
  "tool": "mcp__gong__retrieve_transcripts",
  "callIds": ["call_abc123", "call_def456"]
}
```

**Example response:**

```json
{
  "transcripts": [
    {
      "callId": "call_abc123",
      "title": "Quarterly Business Review - ACME Nonprofit",
      "participants": [
        {
          "speakerId": "speaker_1",
          "name": "Jane Smith",
          "email": "jane@acmenonprofit.org"
        },
        {
          "speakerId": "speaker_2",
          "name": "Sarah Johnson",
          "email": "sarah@feathr.co"
        }
      ],
      "sentences": [
        {
          "speakerId": "speaker_1",
          "start": 120,
          "end": 135,
          "text": "One thing that's been frustrating for our team is not being able to see email performance at the flight level."
        },
        {
          "speakerId": "speaker_1",
          "start": 136,
          "end": 150,
          "text": "We send multiple emails in a campaign and we need to understand which specific sends performed best."
        },
        {
          "speakerId": "speaker_2",
          "start": 151,
          "end": 165,
          "text": "I understand. That's definitely been a common request. Let me make sure our product team hears about this."
        },
        {
          "speakerId": "speaker_1",
          "start": 480,
          "end": 510,
          "text": "Honestly, if we don't get better reporting tools soon, we're going to have to look at alternatives. Our leadership is pushing us to use data-driven decisions and we just can't with the current setup."
        }
      ]
    }
  ]
}
```

**What to extract:**

**Feature requests/pain points:**
- Look for customer statements about "need", "want", "wish we could", "missing", "can't currently"
- Extract specific feature descriptions
- Note workflows that aren't supported

**Urgency/sentiment indicators:**
- **High urgency:** "urgent", "critical", "blocker", "can't proceed", "ASAP"
- **Frustration:** "frustrated", "frustrating", "annoying", "painful", "disappointed"
- **Churn risk:** "looking at alternatives", "considering switching", "evaluating [competitor]", "deal breaker"
- **Leadership pressure:** "executive team", "board", "leadership wants", "C-suite asking"

**Competitive mentions:**
- Names of competitors (Givebutter, Donorbox, Classy, etc.)
- "They have this feature", "Competitor X does this better"

**Customer context:**
- Organization name from title/participants
- Customer role/title (if mentioned)
- Use case/workflow details

**Extracting quotes:**

For each feature request mentioned:
1. Identify all relevant sentences (may span multiple speaker turns)
2. Extract verbatim quote
3. Note speaker name and timestamp
4. Include context (what problem they're trying to solve)

**Example extraction:**

```markdown
**Feature:** Flight-level email activity tables
**Quote:** "One thing that's been frustrating for our team is not being able to see email performance at the flight level. We send multiple emails in a campaign and we need to understand which specific sends performed best."
**Customer:** Jane Smith, ACME Nonprofit
**Call Date:** 2026-01-10
**Urgency Indicator:** Later in call: "if we don't get better reporting tools soon, we're going to have to look at alternatives"
**Urgency Score:** 90 (churn risk language)
```

---

### Sentiment Analysis from Transcripts

**Manual keyword matching:**

Since Gong transcripts are text, use keyword matching to detect sentiment:

**High urgency keywords:**
- urgent, urgently, ASAP, as soon as possible
- critical, blocker, blocking, can't proceed
- must have, non-negotiable, deal breaker

**Frustration keywords:**
- frustrated, frustrating, annoying
- painful, difficult, time-consuming
- disappointed, unhappy

**Churn risk keywords:**
- alternatives, switching, moving to
- evaluating, considering, looking at
- [competitor name]
- cancel, canceling, not renewing

**Score mapping:**

If transcript contains:
- Any churn risk keywords → Urgency score: 90-100
- Any frustration keywords + high urgency → Urgency score: 80-90
- Only high urgency keywords → Urgency score: 70-80
- Medium urgency language → Urgency score: 50-70
- No urgency indicators → Urgency score: 40-50

---

### Focusing on Customer-Facing Calls

Filter calls to focus on customer conversations:

**Include:**
- Calls with external participants (email domains not @feathr.co)
- Call titles containing: "QBR", "review", "demo", "onboarding", "check-in", customer names
- Calls with "customer" role in participants

**Exclude:**
- Internal meetings (all participants @feathr.co)
- Recruiting calls
- Vendor/partner calls (unless they mention customer feedback)

---

## Planhat MCP Tools

Planhat's MCP server uses three flexible, generic tools that work with any Planhat data model. This approach allows querying Companies, Conversations, Activities, and other models dynamically.

### Tool: `mcp__planhat__get_model_actions`

**Purpose:** Discover available Planhat data models and their supported operations.

**Parameters:** None

**Example call:**

```json
{
  "tool": "mcp__planhat__get_model_actions"
}
```

**Example response:**

```json
[
  {
    "model": "companies",
    "operations": ["create", "update", "view", "list"]
  },
  {
    "model": "conversations",
    "operations": ["create", "update", "view", "list"]
  },
  {
    "model": "activities",
    "operations": ["view", "list"]
  },
  {
    "model": "endusers",
    "operations": ["create", "update", "view", "list"]
  }
]
```

**Usage pattern:**
1. Call this first to discover what models and operations are available
2. Note: Available models depend on your Private App permissions
3. Use the model names and operations with `perform_model_action`

---

### Tool: `mcp__planhat__get_model_action_parameters`

**Purpose:** Get the parameter schema for a specific model-operation combination.

**Parameters:**
- `MODEL_ROUTE` (required): Target data model (e.g., "companies", "conversations")
- `OPERATION` (required): Desired operation ("create", "update", "view", "list")

**Example call:**

```json
{
  "tool": "mcp__planhat__get_model_action_parameters",
  "MODEL_ROUTE": "companies",
  "OPERATION": "list"
}
```

**Example response:**

```json
{
  "parameters": {
    "limit": {"type": "integer", "description": "Number of results"},
    "offset": {"type": "integer", "description": "Pagination offset"},
    "sort": {"type": "string", "description": "Sort field"},
    "filter": {"type": "object", "description": "Filter criteria"}
  },
  "required": []
}
```

**Usage pattern:**
1. Call this to understand what parameters are available for a specific operation
2. Use the schema to build valid requests for `perform_model_action`

---

### Tool: `mcp__planhat__perform_model_action`

**Purpose:** Execute CRUD operations on Planhat data.

**Parameters:**
- `MODEL_ROUTE` (required): Target data model (e.g., "companies", "conversations")
- `OPERATION` (required): Operation type ("create", "update", "view", "list")
- `PARAMETERS` (required): JSON string containing operation-specific data

**Example call - List companies with low health:**

```json
{
  "tool": "mcp__planhat__perform_model_action",
  "MODEL_ROUTE": "companies",
  "OPERATION": "list",
  "PARAMETERS": "{\"limit\": 50, \"sort\": \"health\"}"
}
```

**Example response:**

```json
{
  "data": [
    {
      "id": "company_abc123",
      "name": "ACME Nonprofit",
      "health": 35,
      "mrr": 450,
      "churnRisk": "high",
      "lastActivity": "2026-01-10T14:00:00Z"
    }
  ]
}
```

**Example call - List conversations:**

```json
{
  "tool": "mcp__planhat__perform_model_action",
  "MODEL_ROUTE": "conversations",
  "OPERATION": "list",
  "PARAMETERS": "{\"limit\": 100}"
}
```

---

### Workflow for Feedback Analysis

**Step 1: Discover available models**
```
Call: get_model_actions
→ Identifies available models (companies, conversations, activities, etc.)
```

**Step 2: Get parameter schemas (optional)**
```
Call: get_model_action_parameters(MODEL_ROUTE="companies", OPERATION="list")
→ Understand filtering/sorting options
```

**Step 3: Fetch companies with health data**
```
Call: perform_model_action(MODEL_ROUTE="companies", OPERATION="list", PARAMETERS="{...}")
→ Get customer list with health scores, ARR, churn risk
```

**Step 4: Fetch conversations for feedback extraction**
```
Call: perform_model_action(MODEL_ROUTE="conversations", OPERATION="list", PARAMETERS="{...}")
→ Get CSM notes containing feature requests, pain points
```

---

### What to Extract from Planhat Data

**From Companies:**
- `name` - Company/customer name for deduplication
- `health` - Health score (0-100) for urgency weighting
- `mrr`/`arr` - Revenue data for priority weighting
- `churnRisk` - Direct churn risk indicator
- `lastActivity` - Recency indicator

**From Conversations:**
- Content containing feature requests, pain points, feedback
- Customer identification for frequency counting
- Timestamps for recency
- Tags that may indicate feature requests or escalations

**From Activities:**
- Activity patterns indicating frustration (high support volume)
- Feature usage gaps
- Support activity linked to feature requests

**Extracting feedback from conversations:**

CSM notes often contain indirect feedback. Look for:
- **Feature requests:** "Customer asked for...", "They need...", "Requested..."
- **Pain points:** "Frustrated with...", "Struggling to...", "Can't do..."
- **Urgency signals:** "Blocking...", "Escalated...", "Critical for..."
- **Competitive mentions:** "Mentioned [competitor]...", "Looking at alternatives..."
- **Churn signals:** "May not renew...", "Evaluating options..."

**Example extraction:**

```markdown
**Feature:** Flight-level email activity tables
**Quote (CSM note):** "Customer expressed frustration with email reporting. They need to see flight-level performance data but currently export to CSV. Requested this feature multiple times. Said it's blocking their executive reporting workflow."
**Customer:** ACME Nonprofit
**Date:** 2026-01-10
**Health Score:** 35 (low - at-risk customer)
**Urgency:** High (churn risk + blocking workflow)
```

---

### Health Score Interpretation

Planhat health scores provide urgency context:

| Health Score | Urgency Boost | Interpretation |
|--------------|---------------|----------------|
| 0-25 | +30 pts | Critical - high churn risk, prioritize feedback |
| 26-50 | +20 pts | At-risk - significant churn potential |
| 51-75 | +10 pts | Moderate - some concerns |
| 76-100 | +0 pts | Healthy - standard priority |

Apply health score boost to urgency calculations:

```python
base_urgency = calculate_urgency_from_content(conversation)
health_boost = get_health_boost(company.health)
final_urgency = min(100, base_urgency + health_boost)
```

---

### ARR-Weighted Prioritization

When Planhat provides ARR data, optionally weight by revenue impact:

**Method 1: ARR multiplier**
```python
arr_multiplier = 1 + (company.arr / 10000)  # e.g., $50K ARR = 6x multiplier
weighted_frequency = frequency * arr_multiplier
```

**Method 2: ARR buckets**

| ARR Tier | Multiplier | Example |
|----------|------------|---------|
| <$5K | 1.0x | Starter customers |
| $5K-$25K | 1.5x | Growth customers |
| $25K-$100K | 2.0x | Mid-market |
| >$100K | 3.0x | Enterprise |

Use ARR weighting when:
- Prioritizing for revenue retention
- Enterprise feedback analysis
- Churn risk mitigation planning

---

### Linking Planhat to Other Sources

**Cross-source customer matching:**

Planhat provides authoritative customer data (name, email, company). Use this to:
1. Match Canny posts to specific customers via email
2. Enrich Zendesk tickets with ARR/health context
3. Link Gong call participants to company records

**Example matching logic:**

```python
# Get Planhat customer list with emails
planhat_customers = {
    contact.email.lower(): {
        "company": company.name,
        "arr": company.arr,
        "health": company.health,
        "tier": company.tier
    }
    for company in planhat_companies
    for contact in company.contacts
}

# Enrich Canny post with Planhat data
canny_email = canny_post.author.email.lower()
if canny_email in planhat_customers:
    post.arr = planhat_customers[canny_email]["arr"]
    post.health = planhat_customers[canny_email]["health"]
    post.tier = planhat_customers[canny_email]["tier"]
```

---

## Cross-Source Data Integration

### Deduplicating Customers Across Sources

**Goal:** Count each customer once even if they appear in multiple sources.

**Process:**

1. **Extract customer identifiers from each source:**
   - **Canny:** `author.email` from posts, `author.email` from comments
   - **Zendesk:** `requester.email` from tickets
   - **Gong:** `participants.email` where `role = "customer"`
   - **Planhat:** `contacts.email` from companies, company names from conversations

2. **Normalize emails:**
   - Convert to lowercase
   - Trim whitespace

3. **Create unified customer list:**
   ```python
   customers = set()

   # From Canny
   customers.add(canny_post.author.email.lower())

   # From Zendesk
   customers.add(zendesk_ticket.requester.email.lower())

   # From Gong
   for participant in gong_call.participants:
       if participant.role == "customer":
           customers.add(participant.email.lower())

   # From Planhat
   for contact in planhat_company.contacts:
       customers.add(contact.email.lower())

   # Frequency = total unique customers
   frequency = len(customers)
   ```

4. **Note multi-source mentions:**

If same customer appears in 2+ sources, flag in report:
```markdown
**Customers:** 12 total (8 Canny-only, 2 Zendesk-only, 2 multi-source)
**Multi-source examples:**
- Jane Smith (jane@acmenonprofit.org): Canny vote + Zendesk ticket + Gong call
- Bob Johnson (bob@helpinghands.org): Canny vote + Zendesk ticket
```

Multi-source mentions signal stronger need/urgency.

---

### Combining Timestamps for Recency

**Goal:** Use most recent mention across all sources.

**Process:**

1. **Collect all timestamps:**
   - Canny: `post.updated` (most recent activity), `post.created` (original request)
   - Zendesk: `ticket.updated_at` (most recent comment), `ticket.created_at` (original request)
   - Gong: `call.started` (call date)
   - Planhat: `conversation.date` (conversation/note date), `company.lastActivity`

2. **Find maximum (most recent):**
   ```python
   all_timestamps = [
       canny_post.updated,
       zendesk_ticket.updated_at,
       gong_call.started,
       planhat_conversation.date
   ]

   most_recent = max(all_timestamps)
   ```

3. **Calculate recency score:**
   ```python
   days_since = (today - most_recent).days
   recency_score = calculate_recency_score(days_since)
   ```

---

### Combining Urgency Indicators

**Goal:** Use highest urgency level across all sources.

**Process:**

1. **Extract urgency from each source:**
   - **Canny:** Comment sentiment analysis → urgency score (0-100)
   - **Zendesk:** Priority mapping → urgency score (urgent=100, high=75, normal=50, low=25)
   - **Gong:** Keyword matching → urgency score (0-100)
   - **Planhat:** Health score mapping → urgency boost (0-30 based on health), conversation sentiment

2. **Take maximum:**
   ```python
   urgency_scores = []

   # Canny
   urgency_scores.append(analyze_canny_comments(canny_post))

   # Zendesk
   urgency_scores.append(map_zendesk_priority(zendesk_ticket.priority))

   # Gong
   urgency_scores.append(analyze_gong_transcript(gong_transcript))

   # Planhat
   urgency_scores.append(analyze_planhat_health(planhat_company.health))

   final_urgency = max(urgency_scores)
   ```

**Rationale:** If any customer is highly urgent/frustrated, that signals risk worth addressing.

---

### Merging Quotes and Context

**Goal:** Show representative quotes from each source in report.

**Format:**

```markdown
**Customer Quotes:**
- **Canny** (Post #123, 18 votes): "We need to see email stats broken down by individual flights, not just campaigns."
- **Zendesk** (Ticket #456, High priority): "Currently we have to export CSVs and manually analyze in Excel, which takes hours every week."
- **Gong** (Call 2026-01-10, Jane Smith, ACME Nonprofit): "One thing that's been frustrating for our team is not being able to see email performance at the flight level. Honestly, if we don't get better reporting tools soon, we're going to have to look at alternatives."
```

**Selection criteria:**
- Most specific/detailed quote from each source
- Quotes that add different context/perspectives (not redundant)
- Quotes that show urgency, frustration, or business impact
- Quotes from high-value customers (if ARR data available)

---

## Data Validation and Quality Checks

Before finalizing analysis, validate data quality:

### Check 1: Date Range Coverage

Verify you've fetched data for the full requested date range from each source:

```
✓ Canny: 47 posts from 2025-10-18 to 2026-01-17
✓ Zendesk: 89 tickets from 2025-10-18 to 2026-01-17
✓ Gong: 23 calls from 2025-10-18 to 2026-01-17
```

### Check 2: Source Balance

Ensure reasonable representation from each source:

```
⚠️ Warning: Only 2 Gong calls found. Consider expanding date range or reviewing call filtering criteria.
```

### Check 3: Customer Deduplication

Verify dedupe logic worked:

```
✓ Identified 47 unique customers across all sources
✓ 8 customers mentioned in multiple sources
```

### Check 4: Missing Data

Flag items with incomplete data:

```
⚠️ 3 Zendesk tickets missing requester email - frequency may be undercounted
⚠️ 5 Canny posts missing author info
```

### Check 5: Urgency Distribution

Sanity-check urgency scores:

```
✓ Urgency score distribution:
  - 80-100: 12 items (high urgency)
  - 60-79: 23 items (medium urgency)
  - 40-59: 18 items (low-medium urgency)
  - 0-39: 5 items (low urgency)
```

If all scores are high or all are low, review scoring logic.

---

## Performance and Rate Limiting

### Pagination Strategies

**Canny:**
- Max 50 posts per call
- Use `skip` parameter for pagination
- Recommended: Fetch in batches of 50, stop when dates fall outside range

**Zendesk:**
- Max 100 tickets per call
- Use `page` parameter for pagination
- Recommended: Fetch page-by-page until reaching date cutoff

**Gong:**
- Returns all calls in date range (no pagination needed)
- If very long date ranges, consider splitting into smaller chunks

### Parallel vs. Sequential Calls

**Parallel (recommended):**
```
Execute simultaneously:
- Canny: get_boards + get_posts (all boards)
- Zendesk: get_tickets (first page)
- Gong: list_calls

Wait for all to complete, then process results
```

**Sequential (when needed):**
```
If rate limits are hit:
1. Fetch Canny data
2. Wait 1 second
3. Fetch Zendesk data
4. Wait 1 second
5. Fetch Gong data
```

### Estimated Call Volumes

For a 90-day full review:

```
Canny:
- 1 call: get_boards
- ~5-10 calls: get_posts (multiple boards, pagination)
- ~10-20 calls: get_post (for high-vote items)
Total: ~30 calls

Zendesk:
- ~5-15 calls: get_tickets (pagination)
- ~10-20 calls: get_ticket_comments (high-priority tickets)
Total: ~30 calls

Gong:
- 1 call: list_calls
- 1-3 calls: retrieve_transcripts (batches of call IDs)
Total: ~4 calls

Grand total: ~64 MCP tool calls
```

---

## Summary: Integration Checklist

When running analysis, follow this checklist:

- [ ] **Canny:**
  - [ ] Fetch boards
  - [ ] Fetch posts from relevant boards
  - [ ] Get detailed post info for high-vote items
  - [ ] Extract votes, scores, comments, timestamps, customer info

- [ ] **Zendesk:**
  - [ ] Fetch tickets with date filtering
  - [ ] Filter for feature requests (exclude pure bugs/how-tos)
  - [ ] Get ticket comments for high-priority items
  - [ ] Extract priority, status, timestamps, customer info

- [ ] **Gong:**
  - [ ] List calls in date range
  - [ ] Filter for customer-facing calls
  - [ ] Retrieve transcripts for relevant calls
  - [ ] Extract feature requests, urgency keywords, customer info

- [ ] **Planhat:**
  - [ ] Discover available models with `get_model_actions`
  - [ ] Fetch companies with health scores using `perform_model_action`
  - [ ] Get conversations within date range
  - [ ] Filter for conversations containing feature requests/feedback
  - [ ] Extract health scores, ARR, churn risk, CSM notes
  - [ ] Use customer data to enrich other sources

- [ ] **Cross-source integration:**
  - [ ] Deduplicate customers by email
  - [ ] Use most recent timestamp for recency
  - [ ] Use highest urgency score across sources
  - [ ] Apply Planhat health score boost to urgency
  - [ ] Optionally weight by ARR from Planhat
  - [ ] Merge quotes and context from all sources

- [ ] **Data validation:**
  - [ ] Verify date range coverage
  - [ ] Check source balance
  - [ ] Confirm deduplication worked
  - [ ] Flag missing data
  - [ ] Sanity-check score distributions

This integration ensures comprehensive, high-quality feedback analysis from all available sources.

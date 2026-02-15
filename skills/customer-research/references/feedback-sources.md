# Feedback Sources Reference

Common sources of customer feedback and how to access them.

## Direct Feedback Channels
- **Support tickets**: Zendesk, Intercom, Freshdesk, Help Scout
- **NPS/CSAT surveys**: Delighted, Wootric, SurveyMonkey, Typeform
- **In-app feedback**: Productboard, Canny, UserVoice, Pendo
- **User interviews**: Transcripts from Dovetail, Grain, Otter.ai

## Indirect Feedback Signals
- **App store reviews**: iOS App Store, Google Play
- **Social media**: Twitter mentions, Reddit threads, community forums
- **Sales/CS calls**: Gong, Chorus transcripts
- **Churn surveys**: Responses from departing customers
- **Usage analytics**: Amplitude, Mixpanel, PostHog session recordings

## Data Import Formats

### CSV
Best for structured data. Expected columns:
- `feedback` or `text` — the feedback content
- `source` — where it came from (optional)
- `date` — when received (optional)
- `user` or `customer` — who said it (optional)
- `segment` — customer segment (optional)

### JSON
Array of objects with similar fields:
```json
[
  {
    "text": "I wish I could export reports as PDF",
    "source": "support_ticket",
    "date": "2025-01-15",
    "segment": "enterprise"
  }
]
```

### Plain Text
One piece of feedback per line, or clearly separated blocks. Source and date can be noted inline.

## MCP Integration

For real-time access to feedback tools, configure MCP servers via `/pm-setup`. This enables querying Intercom conversations, Zendesk tickets, or Productboard insights directly from Claude Code.

# Analysis Frameworks Reference

## Affinity Mapping

Process for grouping feedback into themes:
1. Read through all feedback items
2. Identify recurring topics, words, and sentiments
3. Group related items together (even if worded differently)
4. Name each group with a clear, descriptive theme label
5. Count items per theme for frequency analysis
6. Note which customer segments appear in each theme

## Jobs-to-Be-Done (JTBD)

Framework for understanding what users are really trying to accomplish:

**Job statement format**: "When [situation], I want to [motivation], so I can [expected outcome]."

For each major theme, identify:
- **The job**: What is the user fundamentally trying to do?
- **Current solution**: How do they accomplish this today?
- **Pain points**: What makes the current solution inadequate?
- **Desired outcome**: What would success look like?
- **Hiring criteria**: What would make them "hire" a new solution?

## Pain Point Severity Matrix

Rate each pain point on two dimensions:

| | Low Frequency | High Frequency |
|---|---|---|
| **High Severity** | Monitor — painful but rare | Fix urgently — painful and common |
| **Low Severity** | Ignore — minor and rare | Improve — annoying and common |

**Severity factors:**
- Blocks user from completing their job
- Causes data loss or errors
- Requires workaround or manual intervention
- Creates frustration or confusion
- Impacts revenue or retention

**Frequency factors:**
- Number of unique users reporting
- Number of mentions across channels
- Trend direction (increasing, stable, decreasing)
- Breadth across customer segments

## Impact Scoring

For prioritizing what to act on:

```
Impact Score = Frequency (1-5) × Severity (1-5) × Breadth (1-3)
```

- **Frequency**: How often is this reported? (1=rare, 5=daily)
- **Severity**: How painful? (1=cosmetic, 5=blocker)
- **Breadth**: How many segments affected? (1=one, 2=some, 3=all)

## Sentiment Analysis Categories

- **Strongly positive**: Enthusiastic praise, unsolicited recommendations
- **Positive**: Satisfaction, appreciation
- **Neutral**: Factual observation, question
- **Negative**: Frustration, complaint, workaround mention
- **Strongly negative**: Churn threat, anger, escalation

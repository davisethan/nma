WITH scores AS (
    SELECT
        dataset,
        pipeline,
        subject,
        AVG(score) AS mean_session_score
    FROM results
    GROUP BY dataset, pipeline, subject
),

paired AS (
    SELECT
        a.dataset,
        a.pipeline AS pipeline_a,
        b.pipeline AS pipeline_b,
        a.mean_session_score - b.mean_session_score AS diff
    FROM scores AS a
    INNER JOIN scores AS b
        ON
            a.dataset = b.dataset
            AND a.subject = b.subject
            AND a.pipeline < b.pipeline
)

SELECT
    dataset AS study,
    pipeline_a AS treat1,
    pipeline_b AS treat2,
    AVG(diff) AS md,
    STDDEV_SAMP(diff) / SQRT(COUNT(*)) AS se
FROM paired
GROUP BY dataset, pipeline_a, pipeline_b
ORDER BY dataset, pipeline_a, pipeline_b

-- 1. 大盘核心指标汇总
select
    sum(shop.GMV),
    sum(cpc总费用),
     ROUND(SUM(gmv) / NULLIF(SUM(cpc总费用), 0), 2),
    ROUND(SUM(cpc曝光量) / NULLIF(SUM(进店人数), 0), 4),
    ROUND(SUM(下单人数) / NULLIF(SUM(进店人数), 0), 4)
from ddm.shop
left join ddm.cpc
on cpc.门店id=shop.门店ID
and cpc.日期=shop.日期;

-- 2. 门店级别 ROAS 与补贴率诊断（按 ROAS 降序）
SELECT
    门店名称,
    SUM(gmv) AS gmv,
    SUM(cpc总费用) AS cpc_cost,
    ROUND(SUM(gmv) / NULLIF(SUM(cpc总费用), 0), 2) AS store_roas,
    ROUND(SUM(商户补贴) / NULLIF(SUM(gmv), 0), 4) AS merchant_subsidy_rate
FROM ddm.shop
left join ddm.cpc
on shop.门店ID = cpc.门店ID
and shop.日期 = cpc.日期
GROUP BY 门店名称;

-- 3. 门店表现 Top / Bottom 诊断分组
WITH store_perf AS (
    SELECT
        门店名称,
        ROUND(SUM(gmv) / NULLIF(SUM(cpc总费用), 0), 2) AS roas,
        ROUND(SUM(商户补贴) / NULLIF(SUM(gmv), 0), 4) AS subsidy_rate,
        ROW_NUMBER() OVER (ORDER BY SUM(gmv) / NULLIF(SUM(cpc总费用), 0) DESC) AS roas_rank_desc,
        ROW_NUMBER() OVER (ORDER BY SUM(gmv) / NULLIF(SUM(cpc总费用), 0) ASC) AS roas_rank_asc
    FROM ddm.shop left join ddm.cpc on shop.门店ID = cpc.门店ID and shop.日期=cpc.日期
    GROUP BY 门店名称
)
SELECT
    门店名称,
    roas,
    subsidy_rate,
    CASE
        WHEN roas_rank_desc <= 3 THEN '标杆门店-建议追加预算'
        WHEN roas_rank_asc <= 3 AND subsidy_rate > 0.5 THEN '高危低效店-建议削减补贴'
        ELSE '常态运营店'
    END AS 诊断策略建议
FROM store_perf
ORDER BY roas DESC;
# 外卖店铺 CPC 广告投放效果与 ROI 优化诊断

## 📌 项目背景
本项目针对 10 家外卖店铺的 CPC 广告投放数据及订单数据，通过 SQL 数据建模与 Tableau 可视化看板，诊断各店铺广告投放 ROI/ROAS 差异，识别高补贴低产出的异常店铺，为营销预算重分配提供策略建议。

## 🛠️ 使用工具
- **数据存储与分析**：MySQL / DataGrip (SQL)
- **可视化诊断**：Tableau Desktop / Tableau Public
- **核心 SQL 技巧**：聚合函数、窗口函数 (`ROW_NUMBER`)、`CTE` 临时表、`CASE WHEN` 条件诊断

## 📊 核心指标定义
- **ROAS (Return on Ad Spend)** = $GMV / CPC\ Expense$
- **商户补贴率** = $Merchant\ Subsidy / GMV$
- **全链路转化** = $Exposure \rightarrow Visit \rightarrow Order$

## 📂 项目产出
1. **SQL 代码**：详见 [`cpp_ad_analysis.sql`](./cpp_ad_analysis.sql)
2. **Tableau 交互看板**：可在线查看并下钻诊断看板

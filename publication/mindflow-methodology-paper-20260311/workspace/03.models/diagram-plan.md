# Diagram Plan

## 图 1 问题断裂图

**目的**:

展示现有 Agent / MAS / workflow 系统的三类断裂：

1. 方法论约束难进入运行时
2. 知识难内化为稳定能力
3. 执行与学习难形成闭环

**建议形式**:

`flowchart LR`

**主要支撑来源**:

- SRC-001
- SRC-008
- SRC-009
- SRC-012
- SRC-018

## 图 2 Mind 七层总体框架图

**目的**:

展示 `Soul`、`Recognition`、`Analysis`、`Execution`、`Reflection`、`Learning`、`Inference` 之间的结构关系，并明确 `Execution Control` 属于 `Execution` 内部的运行控制机制，而非 `Mind` 本体层级。

**建议形式**:

`flowchart TB`

**主要支撑来源**:

- SRC-002
- SRC-003
- SRC-004
- SRC-011
- SRC-014
- SRC-015

## 图 3 主流程图

**目的**:

展示 MindFlow 的正式流程：

`Task -> Learning(Read) -> Recognition -> Analysis -> Execution -> Plan -> Execution Control -> Reflection -> Learning`

**建议形式**:

`flowchart LR`

**主要支撑来源**:

- SRC-001
- SRC-002
- SRC-005

## 图 4 Soul 与心智模型约束作用图

**目的**:

展示高层方法论原则、认知偏好和组织目标如何经由 `Soul` 约束识别、分析、推衍、反思和学习。

**建议形式**:

`graph TD`

**主要支撑来源**:

- SRC-003
- SRC-008
- SRC-009
- SRC-013

## 图 5 Inference 推衍机制图

**目的**:

展示 `Inference` 在知识缺口、风险预判、路径推演与学习方向选择中的作用。

**建议形式**:

`flowchart LR`

**主要支撑来源**:

- SRC-004
- SRC-011
- SRC-014
- SRC-015

## 图 6 知识内化与 Capacity 转化图

**目的**:

展示外部知识如何经过学习、审核与沉淀，最终转化为 `Capacity`，并反过来服务执行。

**建议形式**:

`flowchart LR`

**主要支撑来源**:

- SRC-001
- SRC-006
- SRC-007
- SRC-008
- SRC-010
- SRC-013

## 图 7 Execution / Plan / Execution Control 并行 MAS 图

**目的**:

展示方法论如何落到协议化运行机制，说明为什么该层是工程亮点。

**建议形式**:

`flowchart TB`

**主要支撑来源**:

- SRC-001
- SRC-002
- SRC-005

## 图 8 组织场景约束传导图

**目的**:

展示组织方法论、认知偏好与发展目标如何进入 `Soul`，再作用于学习与长期演进。

**建议形式**:

`graph LR`

**主要支撑来源**:

- SRC-003
- SRC-008
- SRC-009
- SRC-010
- SRC-013

## 表 1 范式对比表

**目的**:

将 MindFlow 与普通 Agent workflow、传统 MAS 编排系统、传统知识管理系统、传统软件结构进行比较。

**比较维度**:

1. 高层约束
2. 知识执行化
3. 能力沉淀
4. 目标一致性
5. 反思学习闭环
6. 可控自主演进

**主要支撑来源**:

- SRC-001
- SRC-002
- SRC-008
- SRC-009
- SRC-012
- SRC-018

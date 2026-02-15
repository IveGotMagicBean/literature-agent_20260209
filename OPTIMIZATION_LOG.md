# ReduceCustom 算子优化记录

## 基础信息
- 原始代码来源：ops-math/experimental/math/reduce_sum_v2
- 改造时间：2025-02-15
- 改造目的：适配昇腾AI算法挑战赛 Reduce 算子优化任务

## 已完成的改造

### 1. 文件重命名
- reduce_sum_v2 → reduce_custom
- ReduceSumV2 → ReduceCustom
- NsReduceSumV2 → NsReduceCustom

### 2. 核心功能（已实现）
- ✅ 多核并行支持（自动分配到多个 AI Core）
- ✅ 多维归约支持（axis = 0, 1, 或全归约）
- ✅ 高维 Shape 支持（rows × cols 二维模式）
- ✅ 原子操作同步（AtomicAdd）
- ✅ 分块处理（Tiling）避免 UB 空间不足
- ✅ 支持 float32 和 float16 数据类型

### 3. 代码结构
```
0215_test01/
├── op_kernel/
│   ├── reduce_custom.cpp          # Kernel 入口
│   ├── reduce_custom.h            # 核心算法实现（358行）
│   ├── reduce_custom_tiling_data.h
│   └── reduce_custom_tiling_key.h
├── op_host/
│   ├── reduce_custom_def.cpp      # 算子定义
│   ├── reduce_custom_infershape.cpp
│   └── reduce_custom_tiling.cpp   # Tiling 策略
├── examples/
│   └── test_aclnn_reduce_custom.cpp
├── install.sh                      # 编译脚本
└── ReduceCustom.json              # 算子原型定义

## 下一步优化方向

### 创新点1：优化 Tiling 策略
- [ ] 针对 [2048, 2048, 2048] 等高维场景优化分块大小
- [ ] 动态调整 tileDataNum 根据实际 UB 大小

### 创新点2：减少同步开销
- [ ] 优化 workspace 大小（当前 SLOT_STRIDE = 64）
- [ ] 尝试使用 DataCacheClean 减少缓存失效

### 创新点3：内存访问优化
- [ ] 添加数据预取（Prefetch）
- [ ] 优化内存对齐策略

### 创新点4：计算优化
- [ ] 尝试使用更高效的归约模式
- [ ] 针对特定 Shape 优化计算流程

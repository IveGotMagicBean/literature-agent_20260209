#!/bin/bash
# 批量替换代码中的符号

echo "开始替换代码符号..."

# 定义替换规则
# ReduceSumV2 -> ReduceCustom
# reduce_sum_v2 -> reduce_custom
# REDUCE_SUM_V2 -> REDUCE_CUSTOM

# 替换 op_kernel 文件
echo "处理 op_kernel 文件..."
sed -i 's/ReduceSumV2/ReduceCustom/g' op_kernel/*.h op_kernel/*.cpp 2>/dev/null
sed -i 's/reduce_sum_v2/reduce_custom/g' op_kernel/*.h op_kernel/*.cpp 2>/dev/null
sed -i 's/REDUCE_SUM_V2/REDUCE_CUSTOM/g' op_kernel/*.h op_kernel/*.cpp 2>/dev/null
sed -i 's/NsReduceSumV2/NsReduceCustom/g' op_kernel/*.h op_kernel/*.cpp 2>/dev/null

# 替换 op_host 文件
echo "处理 op_host 文件..."
sed -i 's/ReduceSumV2/ReduceCustom/g' op_host/*.cpp 2>/dev/null
sed -i 's/reduce_sum_v2/reduce_custom/g' op_host/*.cpp 2>/dev/null
sed -i 's/REDUCE_SUM_V2/REDUCE_CUSTOM/g' op_host/*.cpp 2>/dev/null

# 替换 examples 文件
echo "处理 examples 文件..."
sed -i 's/ReduceSumV2/ReduceCustom/g' examples/*.cpp 2>/dev/null
sed -i 's/reduce_sum_v2/reduce_custom/g' examples/*.cpp 2>/dev/null
sed -i 's/aclnnReduceSumV2/aclnnReduceCustom/g' examples/*.cpp 2>/dev/null

# 替换 CMakeLists.txt
echo "处理 CMakeLists.txt..."
sed -i 's/reduce_sum_v2/reduce_custom/g' CMakeLists.txt op_host/CMakeLists.txt 2>/dev/null
sed -i 's/ReduceSumV2/ReduceCustom/g' CMakeLists.txt op_host/CMakeLists.txt 2>/dev/null

echo "代码符号替换完成！"

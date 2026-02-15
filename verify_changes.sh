#!/bin/bash
# 验证改造结果

echo "=== 验证文件名 ==="
echo "op_kernel 文件:"
ls op_kernel/

echo ""
echo "op_host 文件:"
ls op_host/ | grep -v config | grep -v CMakeLists

echo ""
echo "=== 检查代码中是否还有 reduce_sum_v2 字样 ==="
echo "op_kernel:"
grep -n "reduce_sum_v2\|ReduceSumV2" op_kernel/*.h op_kernel/*.cpp 2>/dev/null | head -5
if [ $? -ne 0 ]; then
    echo "✅ op_kernel 中没有残留的 reduce_sum_v2"
fi

echo ""
echo "op_host:"
grep -n "reduce_sum_v2\|ReduceSumV2" op_host/*.cpp 2>/dev/null | head -5
if [ $? -ne 0 ]; then
    echo "✅ op_host 中没有残留的 reduce_sum_v2"
fi

echo ""
echo "=== 检查新符号是否正确 ==="
echo "查找 ReduceCustom 类定义:"
grep -n "class ReduceCustom" op_kernel/*.h | head -3

echo ""
echo "查找 namespace NsReduceCustom:"
grep -n "namespace NsReduceCustom" op_kernel/*.h | head -3

echo ""
echo "=== 验证完成 ==="

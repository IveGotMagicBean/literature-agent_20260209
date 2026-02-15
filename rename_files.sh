#!/bin/bash
# 文件重命名脚本 - 将 reduce_sum_v2 改为 reduce_custom

echo "开始重命名文件..."

# 重命名 op_kernel 目录下的文件
cd op_kernel
mv reduce_sum_v2.cpp reduce_custom.cpp
mv reduce_sum_v2.h reduce_custom.h
mv reduce_sum_v2_tiling_data.h reduce_custom_tiling_data.h
mv reduce_sum_v2_tiling_key.h reduce_custom_tiling_key.h
cd ..

# 重命名 op_host 目录下的文件
cd op_host
mv reduce_sum_v2_def.cpp reduce_custom_def.cpp
mv reduce_sum_v2_infershape.cpp reduce_custom_infershape.cpp
mv reduce_sum_v2_tiling.cpp reduce_custom_tiling.cpp
cd ..

# 重命名 examples 目录下的文件
if [ -f examples/test_aclnn_reduce_sum_v2.cpp ]; then
    mv examples/test_aclnn_reduce_sum_v2.cpp examples/test_aclnn_reduce_custom.cpp
fi

echo "文件重命名完成！"
echo ""
echo "=== 重命名后的文件列表 ==="
echo "op_kernel:"
ls -1 op_kernel/
echo ""
echo "op_host:"
ls -1 op_host/ | grep -v config | grep -v CMakeLists

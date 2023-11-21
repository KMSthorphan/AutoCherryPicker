#!/bin/bash

# Nhập giá trị từ người dùng
read -p "Log type (eg: bug or feature): " value1
read -p "Log name (eg: LOG-001 or LOG-002): " value2
read -p "Commit ID: " value3

if [ -z "$value1" ] || [ -z "$value2" ] || [ -z "$value3" ]; then
  echo "Missing input"
  read
  exit 1
fi

# Khởi tạo mảng để lưu trữ tên branch
branch_names=("release1" "release2")

# Vòng lặp để thực hiện công việc cho từng branch
for branch_name in "${branch_names[@]}"; do
  # Generate tên cho branch
  echo -n "-------------------------------------------"
  new_branch="${value1}/${branch_name}/${value2}"
  echo -n "Creating branch $new_branch"

  # Checkout từ branch đã được khai báo
  git checkout $branch_name

  # Cherry pick từ value3
  git cherry-pick $value3

  # Push commit và branch lên
  git push origin $new_branch

  # Quay lại branch trước đó
  git checkout -

  echo -n "-------------------------------------------"

done

echo -n "Process Completed!"
read
# 다운로드할 폴더 생성
mkdir -p DummyImage
cd picsum_3024x4032

# 1부터 50까지 반복하며 이미지 다운로드
for i in {1..50}; do
  URL="https://picsum.photos/id/$i/270/360"
  FILE_NAME="image_$i.jpg"
  
  echo "Downloading $FILE_NAME (ID: $i)..."
  
  # curl을 사용하여 이미지 다운로드 및 파일 이름 지정
  curl -L -o "$FILE_NAME" "$URL"
  
  echo "Done."
done

echo "Download complete! Total 50 images saved in $(pwd)"

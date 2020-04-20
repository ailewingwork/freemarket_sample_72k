$(document).ready(function(){
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<label class="UploadBtnArea" for="item_images_attributes_${index}_image"><div class="js-file_group" data-id="${index}">
                    <i class="fas fa-camera UploadIcon"></i>
                    <input class="UploadBtn" type="file" name="item[images_attributes][${index}][image]" id="item_images_attributes_${index}_image">
                    <br>ドラッグアンドドロップ<br>
                    またはクリックしてファイルをアップロード
                  </div>`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

  $('.upload').on('change','.js-file', function(e){
    $('.Upload').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    console.log(fileIndex);
  })
});
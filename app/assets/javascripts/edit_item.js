$(function(){
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#EditImg').change(function(){
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();

      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files

      let num = $('.ItemImage').length + 1
      fileReader.readAsDataURL(file);
      //画像が5枚になったら画像投稿フォームを削除する
      if (num == 5){
        $('.Upload').css('display', 'none')
      }
      //読み込みが完了すると、imageにfileのURLを格納
      fileReader.onloadend = function() {
        let image = fileReader.result

        let html = `<div class='ItemImage' data-image="${file.name}">
                      <div class='ItemImage__Content'>
                        <div class='ItemImage__Content--Icon'>
                          <img src=${image} width="114" height="80" >
                        </div>
                      </div>

                      <div class='EditImage_Operetion'>
                        <div class='EditImage_Operetion--Edit' >編集</div>
                      </div>
                      <div class='ItemImage__Operetion'>
                        <div class='ItemImage__Operetion--Delete'>削除</div>
                      </div>
                    </div>`

        let input = `<input type="file" style="display:none" name="item[images_attributes][${num}][image]" id="ImgFile">`

        //#ImageBox要素の小要素として1を差し込む
        $('#ImageBox').append(html);
        $('label').before(input);
      };
    });
  });
});
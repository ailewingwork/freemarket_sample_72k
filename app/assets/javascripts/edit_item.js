$(function(){
  let array = [false, false, false, false, false];
  let length = $('.preview-box').length;
  array.fill(true , 0, length)

  //プレビューのhtmlを定義
  function buildHTML(count) {
    var html = `<div class="ItemImage preview-box AdjustMargin" id="preview-box__${count}">
                  <div class="ItemImage__Content">
                    <div class="ItemImage__Content__Icon">
                      <img src="" alt="preview" width="114" height="80">
                    </div>
                  </div>
                  <div class="ItemImage__Operetion delete-box delete-box" id="delete_btn_${count}">
                    <div class="ItemImage__Operetion--Destroy">
                      削除
                    </div>
                  </div>
                </div>`
    return html;
  }

  if (window.location.href.match(/\/items\/\d+\/edit/)){
    //削除ボタンにidを追加
    $('.delete-box').each(function(index, box){
      $(box).attr('id', `delete_btn_${index}`);
    })
    var count = $('.preview-box').length;
    //プレビューが5あるときは、投稿ボックスを消しておく
    if (count == 5) {
      $('.label-content').hide();
    }
  }

  // プレビューの追加
  $(document).on('change', '.hidden-field', function() {
    //hidden-fieldのidの数値のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    //labelボックスのidとforを更新
    $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
    //選択したfileのオブジェクトを取得
    var file = this.files[0];
    var reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      var image = this.result;
      //プレビューが元々なかった場合はhtmlを追加
      if ($(`#preview-box__${id}`).length == 0) {
        var html = buildHTML(id);
        //ラベルの直前のプレビュー群にプレビューを追加
        var prevContent = $('.Upload').prev();
        $(prevContent).append(html);
      }
      //イメージを追加
      $(`#preview-box__${id} img`).attr('src', `${image}`);
      var count = $('.preview-box').length;
      // プレビューが5個あったらラベルを隠す 
      if (count == 5) { 
        $('.Upload').hide();
      }

      //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す=============
      if ($(`#item_images_attributes_${id}__destroy`)){
        $(`#item_images_attributes_${id}__destroy`).prop('checked',false);
      } 

      array.splice(id, 1, true)
      console.log(array)
      // //ラベルのidとforの値を変更
      if(count < 5){
        $('.label-box').attr({id: `label-box--${array.indexOf(false)}`,for: `item_images_attributes_${array.indexOf(false)}_image`});
      }
    }
  });

  // 画像の削除
  $(document).on('click', '.delete-box', function() {
    var count = $('.preview-box').length;
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    $(`#preview-box__${id}`).remove();
    $(`#item_images_attributes_${id}__destroy`).prop('checked',true);
    //5個めが消されたらラベルを表示
    if (count == 4) {
      $('.Upload').show();
    }
    array.splice(id, 1, false)
    //削除したプレビューのidによって、ラベルのidを変更する
    if(id < 5){
      $('.label-box').attr({id: `label-box--${array.indexOf(false)}`,for: `item_images_attributes_${array.indexOf(false)}_image`});
    }
  });
});

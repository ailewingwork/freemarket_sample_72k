$(function(){
  //出品ボタンをクリックすると発火するイベント
  $('#new_itemID').on('submit', function (e) {
    e.preventDefault();

    // エラー数の初期化
    let errnum = 0

    // 画像が何枚投稿されているかカウントする
    let imagenum = $('#ItemImage').length
    // 商品名の文字数をカウントする
    let itemname_num = $("#ItemName").val().length;
    // 商品の説明の文字数をカウントする
    let itemdes_num = $("#ItemDes").val().length;
    // カテゴリーの内容を取得する
    let category_parent = $("#parent_category").val()
    let category_grandchild  = ""


    // カテゴリーの孫要素の入力欄が商品出品ページに存在していた場合の処理。
    // 変数 category_grandchildにセレクトボックスで選択した内容を代入する
    if ($("#grandchild_category").length){
      category_grandchild = $("#grandchild_category").val()

    }

    // 画像が0枚だったらメッセージを画像投稿フォームの下に出す
    errnum = generate_message(imagenum,'ValidationImage','画像がありません','UploadImage',errnum)

    // 商品名が未入力だったらメッセージを商品名入力フォームの下に出す
    errnum = generate_message(itemname_num,'ValidationItemName','入力してください','ItemName',errnum)

    // 商品名が未入力だったらメッセージを商品名入力フォームの下に出す
    errnum = generate_message(itemdes_num,'ValidationItemDes','入力してください','ItemDes',errnum)

    // カテゴリーの小要素の入力欄が商品出品ページに存在していた場合の処理。
    // 変数 category_childにセレクトボックスで選択した内容を代入する
    if ($("#child_category").length){
      let category_child = $("#child_category").val()
      // カテゴリーが未選択
      if (category_child == "--") {
        errnum = generate_message(category_child,'ValidationCategory','選択してください','PullDownCategory',errnum)
      }
    }

    // バリデーションチェックでエラーが一つ以上あったら画面の先頭にスクロールする
    if (errnum >= 1){
      //画面の先頭にスクロール
      $(window).scrollTop(0) 
    }
  });

  // エラーメッセージを出力する関数
  function generate_message(num,errmessageID,message,afterID,errnum){
    if (num == 0){

      let valnum = $(`#${errmessageID}`).length
      let toperr_num = $(`#TopErr`).length

      //既にバリデーションチェックのメッセージが出力されていない時のみメッセージを出す
      if (valnum == 0){
        let html = `<div class='Validation' id='${errmessageID}'>${message}</div>`
        $(`#${afterID}`).after(html);
      }
      if (toperr_num == 0){
        let topmsg = `<div class='Validation' id='TopErr'>入力していない項目があります。</div>`
        $(`#SellImg`).before(topmsg);
      }

      errnum = errorcount(errnum)
      return errnum
    }
  }

  // エラー数をカウントする関数
  function errorcount(num){
    num = num + 1
    return num
  }



    // let formData = new FormData(this);
    // let url = $(this).attr('action')

    // // items#createにいく
    // $.ajax({
    //   url: url,
    //   type: "POST",
    //   data: formData,
    //   dataType: 'json',
    //   processData: false,
    //   contentType: false
    // })
    // .done(function(data){
    //   // 正常終了した時は特に処理なし
    //   console.log("done")
    // })
    // .fail(function() {
    //   // var log = JSON.stringify(data)

    //   console.log("fail")
    //   $('#SellBtn').prop('disabled', false);

      
    // })
});
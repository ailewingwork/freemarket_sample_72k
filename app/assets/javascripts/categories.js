$(function(){
  $(document).ready(function() {

    // カテゴリーセレクトボックスのオプションを作成
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }


    // 子カテゴリーの表示作成
    function appendChidrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<div id="children_wrapper">
                          <select class= 'SellPage__Information__Box__Inner__Form', id= 'child_category' name="item[category_id]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                        </div>`;
      $('#PullDownCategory').append(childSelectHtml);
    }


    // 孫カテゴリーの表示作成
    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div id="grandchildren_wrapper">
                          <select class= 'SellPage__Information__Box__Inner__Form', id= 'grandchild_category' name="item[category_id]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                        </div>`;
      $('#PullDownCategory').append(grandchildSelectHtml);
    }


    $('#parent_category').on('change', function(){
      // 変数"parentCategory"に、プルダウンで選択した値を代入
      var parentCategory = document.getElementById('parent_category').value;
      if(parentCategory != "---"){
        $.ajax({
          url: 'get_category_children',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
        $('#grandchildren_wrapper').remove();
      }
    });


    // 子カテゴリー選択後のイベント
    $('#PullDownCategory').on('change', '#child_category', function(){
      // カテゴリーの子要素に紐づくIDを取得して、そのIDに紐づく孫要素を取得する。
      // option:selected を指定する事で、プルダウンで選択したものの情報を取得できる事になる。
      var childId = $('#child_category option:selected').data('category');
      if (childId != "---"){
        // 自身で作成したget_category_grandchildrenのルーティングへ飛ばす。その際、プルダウンで選択されている子要素のIDも渡す。
        $.ajax({
          url: 'get_category_grandchildren',
          type: 'GET',
          data: { child_id: childId },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove();
      }
    });
  });
});
$(function(){
  $(document).ready(function(){
    // カテゴリーボタンにカーソルを合わせた時に親カテゴリー一覧を表示する処理
    $(".TopHeader__Inner__Lists__Left__Category").on('mouseover',function() {
      $(".ChildrenMenu__List").css('color','#333333');
      $(".GrandChildrenMenu__List").css('color','#333333');
      $('.CategoryList').css('visibility','visible');
      
    });
    // 親カテゴリーリストからカーソルが離れた時に非表示にする処理
    $(".CategoryList").on('mouseleave',function(){
      $('.CategoryList').css('visibility','hidden');
    });



    // 子カテゴリーを追加するための処理
    function buildChildHTML(child){
      var html =`<a class="ChildrenMenu__List" id="${child.id}" 
                  href="/items/${child.id}/select_category_index">${child.name}</a>`;
      return html;
    }

    // 孫カテゴリを追加する処理です　基本的に子要素と同じです！
    function buildGrandChildHTML(child){
      var html =`<a class="GrandChildrenMenu__List" id="${child.id}"
                href="/items/${child.id}/select_category_index">${child.name}</a>`;
      return html;
    }

    $(".parent_category").on("mouseover", function() {
      // hoverされた選択肢のidを変数に代入
      var id = this.id
      // hoverされた選択肢のカテゴリ名を変数に代入
      var name = this.innerText
      $(".ChildrenMenu__List").remove();
      $(".GrandChildrenMenu__List").remove();
      $(".parent_category").css('color','#333333');
      $(this).css('color','#3CCACE');
      $.ajax({
        type: 'GET',
        url: '/items/get_category_children',
        data: {parent_id: id, parent_name: name},//どの親の要素かを送る。params[:parent_id,:parent_name]で送られる
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {//帰ってきた子カテゴリー（配列）
          var html = buildChildHTML(child);//HTMLにして
          $(".ChildrenMenu").append(html);//リストに追加します
          
        })
      });
    });


    $(document).on("mouseover", ".ChildrenMenu__List", function () {//子カテゴリーのリストは動的に追加されたHTMLのため
      var id = this.id
      // hoverされた選択肢のカテゴリ名を変数に代入
      $(".parent_category").css('color','#333333');
      $(".ChildrenMenu__List").css('color','#333333');
      $(this).css('color','#3CCACE');
      $(".GrandChildrenMenu__List").remove();
      $.ajax({
        type: 'GET',
        url: '/items/get_category_grandchildren',
        data: {child_id: id},
        dataType: 'json'
      })
      .done(function(children) {
        children.forEach(function (child) {
          var html = buildGrandChildHTML(child);
          $(".GrandChildrenMenu").append(html);
        })
        $(document).on("mouseover", ".ChildrenMenu__List", function () {
          $(".GrandChildrenMenu__List").remove();
        });
      });
    }); 
    $(document).on("mouseover", ".GrandChildrenMenu__List", function(){
      $(".ChildrenMenu__List").css('color','#333333');
      $(".GrandChildrenMenu__List").css('color','#333333');
      $(this).css('color','#3CCACE');
    });
  })
});
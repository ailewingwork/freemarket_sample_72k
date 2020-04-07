$(function(){
  function buildHTML(){
    let html_baloon = ""
    html_baloon = html_baloon + 
      `<div class="upper-message">
        <div class="upper-message__user-name">
          ${message.user_name}
        </div>
        <div class="upper-message__date">
          ${message.created_at}
        </div>
      </div>
      <div class="lower-message" data-message-user=${message_user_id}>
        <p class="lower-message__content">
          ${message.content}
        </p>`
    
     return html_baloon;
    };
  }

  $('.TopHeader__Inner__Lists__Left__Category').on('focus', function(){
    //最新のメッセージを設定
    last_message_setter()
    let formData = new FormData(this);
    console.log(this)
    let url = $(this).attr('action')
    // messages#createにいく
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data, current_user, current_user);
        $('.main__messages').append(html);
        $('.main__messages').animate({ scrollTop: $('.main__messages')[0].scrollHeight});
        $('form')[0].reset();
        $('.form__submit').prop('disabled', false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    })
  })

  var reloadMessages = function() {
    //最新のメッセージを設定
    last_message_setter()
    //api/messages#indexにいく
    $.ajax({
      //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
      url: "api/messages",
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'get',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: {id: last_message_id}
    })
    .done(function(messages) {
      if (messages.length !== 0) {
        let insertHTML = '';
        $.each(messages, function(i,message) {
          insertHTML += buildHTML(message, current_user, message.user_id)
        });
        $('.main__messages').append(insertHTML);
        $('.main__messages').animate({ scrollTop: $('.main__messages')[0].scrollHeight});
      };
    })
    .fail(function() {
      alert('error');
    });
  };
});
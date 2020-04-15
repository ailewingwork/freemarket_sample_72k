$(document).ready(function() {
  // 販売価格を入力した時にイベントを発火させる
  $('#EntryPrice').on('change',function(){
    // 手数料の変動の可能性を考慮して、手数料も変数を用意。
    var commission = 10
    var price = $('#EntryPrice').val();
    var sellCommission = price / commission
    // 小数点を切り捨て
    sellCommission = Math.floor(sellCommission);
    var salesProfit = price - sellCommission;

    $('#SellCommission').html(`¥${sellCommission}`);
    $('#SalesProfit').html(`¥${salesProfit}`);
  });
});
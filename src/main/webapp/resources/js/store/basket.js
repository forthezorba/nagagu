$(document).ready(function() {
   	var amount=$('select[name="basket_amount"]');
   	var price=$('th[name="price"]');
   	var shipPrice=$('th[name="shipPrice"]');
   	var total=$('.total')
   	var color = $('select[name=basket_color]');
   	var allsize = $('select[name=basket_size]');
   	
   	
   	var goodsform = $('#goodsform').clone();
	$('.sticky2').html(goodsform).find('.btn').addClass('btn-md').removeClass('btn-lg');
 
	//장바구니
	$('.basket_btn').on('click',function(){
   		if(color.val()==''){
   			alertify.alert('확인','색상을 선택해주세요');
   			return;
   		}
   		if(allsize.val()==''){
   			alertify.alert('확인','사이즈를 선택해주세요');
   			return;
   		}
   		if(!replyer){
			alertify.alert('확인','로그인 해주세요');
   			return;
		}
   		insert_basket();
   		//분기 insert_basket(1);
   	});
	//바로주문(3단계)
   	$('.order_btn').on('click',function(){
   		if(!replyer){alertify.alert('로그인 후 이용 가능합니다');return;}
		alertify.confirm('확인', '바로 구매 하시겠습니까?', function(){
			$('.goodsform').append("<input type='hidden' name='basket_check' value='1'/>");
			var params=$("#goodsform").serialize();
			$.ajax({ 
				type: "post", 
				url: "/order/insertBasket",
				dataType: "json", 
				data: params, 
				success: function (data){
					var url = '/order/basketList2?basket_member='+replyer;
					location.href = url
				},
				error:function(){
					alertify.alert('확인',"ajax통신 실패!!");
				} 
			});		
		},function(){ 
	        	alertify.error('취소')
       	});
   	})
   	function insert_basket(item){
   		var params=$("#goodsform").serialize();
		$.ajax({
			  url: "/order/insertBasket",
              type: "POST",
              data: params,
              async: false,
              dataType: "json",
              contentType:
  				'application/x-www-form-urlencoded; charset=utf-8',
              success: function (retVal) {
            	  console.log(params)
        		if(retVal.res=="OK"){
        				alertify.confirm('확인', '장바구니로 이동하시겠습니까?', function(){
        				location.href= '/order/basketList?basket_member='+replyer+''
        			},function(){ 
       		        	alertify.error('장바구니에 담겼습니다')
   		        	});
				} 
			 }
		}) 
   	};
   	
    function getPrice(){
    	var amount = $('select[name="basket_amount"]').val()
    	var price = $('th[name="price"]').attr('value')*1;
    	$('th[name="price"]').text(price.toLocaleString()+'원');  
    	var shipPrice = $('th[name="shipPrice"]').attr('value')*1;
    	$('th[name="shipPrice"]').text(shipPrice.toLocaleString()+'원');
    	console.log(amount);console.log(price);console.log(shipPrice);
    	var total = (price*1+shipPrice*1)*amount*1
    	$('.total').text(total.toLocaleString()+'원');
    }
    getPrice();
	   	

    //장바구니 2개 밸류 일치시키기
	$('select[name=basket_color]').on('change',function(){
		var value = $(this).val();
		color.val(value);
	})
	$('select[name=basket_size]').on('change',function(){
		var value = $(this).val();
		allsize.val(value);
	})
	$('select[name=basket_amount]').on('change',function(){
		var value = $(this).val();
		amount.val(value);
		getPrice();
	})
});

//좋아요, 팔로우
$(document).ready(function(){
	function checkLike(){
		if(member_id==null){
			return;
		}
		$.ajax({
				  url: "/community/getLikeList",
	              type: "get",
	              data: {'like_member':member_id},
	              dataType:'json',
	              contentType:
	  				'application/x-www-form-urlencoded; charset=utf-8',
	              success: function (retVal) {
	            	  console.log(retVal);
		        	for(var j=0; j<retVal.length; j++){
		        		var num = retVal[j].BNO;
        				var target =$('#'+num); 
        				$(target).find('#far').removeClass('far').addClass('fas')
        			}
				  },
		})
	};
	checkLike();
	//좋아요 insert
	$(document).delegate(".likeBtn","click",function(e){
		e.preventDefault();
		if(member_id==null){
			alertify.alert('로그인 해주세요');
			return;
		}
		var bno = $(this).attr('bno');
		$.ajax({
			  url: "/community/insertLike",
              type: "get",
              data: {'like_bno' : bno,'like_member':member_id},
              dataType:'json',
              contentType:
  				'application/x-www-form-urlencoded; charset=utf-8',
              success: function (retVal) {
            	  console.log(retVal);
            	  if($('#'+bno).find('#far').hasClass('far')){
            		  $('#'+bno).find('#far').removeClass('far').addClass('fas'); //검은하트
            	  }else{
            		  $('#'+bno).find('#far').removeClass('fas').addClass('far'); //하얀하트
            	  }
            	  $('#'+bno).find('#far').text(retVal);
			  }		
		});
	});
	
	//팔로우 버튼 누르기
	$(document).on("click",".follow_btn",function (e){
		e.preventDefault();
		if(member_id==null){
			alertify.alert('로그인 해주세요');
			return;
		}
		var follow_to = this.id
		var follow_from = member_id;
		
		var target =$('[id="'+follow_to+'"]');
		if(member_id==null){alertify.alert('확인','로그인 하세요');return;}
		if(follow_from == follow_to){alertify.alert('확인','본인이시네요');	return;} 
		$.ajax({
			url: "/community/insertFollow",
			type: "get",
			data: { 'follow_from' : follow_from , 'follow_to' : follow_to},
			contentType:
			'application/x-www-form-urlencoded; charset=utf-8',
			success: function (retVal) {
	        	if(retVal=='INSERT'){
	        		//팔로우 추가 하면 (멤버 넘버가 올리 사진들 모두 값 바꿔준다)
	        		$(target).text('following').addClass('flw_btn_active')
	        	}else{
	        		//팔로우 끊으면
	        		$(target).text('follow').removeClass('flw_btn_active')
	        	}
			},
			error:function(request,err){ 
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+err)
				alert("ajax통신 실패!!");
			}
		});
	});
	
	//처음 로드할때 팔로우 한 멤버 팔로우 버튼 바꿔주기~
	function follow_check(){ 
		var	follow_from = member_id;
		if(follow_from == null){
			return
		}
		$.ajax({
			url: "/community/getFollowList",
            type: "get", 
            data: { 'follow_from' : follow_from},
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
            success: function (retVal) {
            	console.log(retVal); 
            	for(var j=0; j<retVal.length; j++){
	        		var follow_to = retVal[j].FOLLOW_TO;
    				var target =$('[id="'+follow_to+'"]'); 
    				console.log(target);
    				$('[id="forthezorba@gmail.com"]')
    				$(target).text('following').addClass('flw_btn_active');
    			}
            },
			error:function(){
				alert("ajax통신 실패!!");
			}
		});
	};
	follow_check();
});
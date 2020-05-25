$(document).ready(function(){
	var replyUL = $('.chat');
	
	showList(1);
	
	function showList(page){
		replyService.getList({bno:bnoValue,page: page|| 1}, function(replyCnt,list){
			console.log(replyCnt)
			console.log(list)
			//-1이면 끝 페이지
			if(page== -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
			}
			
			var str='';
			if(list==null || list.length == 0){
				replyUL.html("");
				return;
			}
			for(var i=0, len=list.length||0; i<len; i++){
				str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str += "	<div><div class='header'><strong class='primary-font'>"+list[i].replyerNick+"</strong>";
				str += "		<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str += "		<p>"+list[i].reply+"</p></div></li>";
			}
			replyUL.html(str);
			showReplyPage(replyCnt);
		});
	}
	//댓글 페이지
	var pageNum =1;
	var replyPageFooter = $('.panel-footer');
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum/10.0) * 10;
		var startNum = endNum - 9;
		var prev = startNum != 1;
		var next = false;
		//댓글 100개 이하?
		if(endNum*10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}	
		if(endNum*10 < replyCnt){
			next = true;
		}
		var str = "<ul class='pagination pull-right pt-4'>";
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>이전</a></li>";
		}
		for(var i=startNum; i<=endNum; i++){
			var active= pageNum==i ? "active":"";
			str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		if(next){
			str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>다음</a></li>";
		}
		str += "</ul></div>";
		console.log(str);
		replyPageFooter.html(str);
	}
	//페이지 이동
	replyPageFooter.on('click','li a', function(e){
		e.preventDefault();
		var targetPageNum = $(this).attr('href');
		pageNum = targetPageNum;
		showList(pageNum);
	})
	
	var modal=$('.reply_modal');
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyerNick = modal.find("input[name='replyerNick']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $('#modalModBtn'); 
	var modalRemoveBtn = $('#modalRemoveBtn'); 
	var modalRegisterBtn = $('#modalRegisterBtn');
	var modalCloseBtn = $('#modalCloseBtn');
    $("#modalCloseBtn").on("click", function(e){
    	modal.modal('hide');
    });
	
	$('#addReplyBtn').on('click',function(e){
		modal.find('input').val('');
		modal.find('input[name="replyer"]').val(replyer);
		modal.find('input[name="replyerNick"]').val(replyerNick);
		modalInputReplyDate.closest('div').hide();
		modal.find('button').hide(); 
		modalRegisterBtn.show();
		modalCloseBtn.show();
		
		$('.reply_modal').modal('show');
	});
	
 	
 	
 	//등록
	modalRegisterBtn.on('click',function(e){
		var arr= [];
		$('.uploadResult ul li').each(function(i,obj){
			var jobj = $(obj);
			var data = {
					fileName: jobj.data("filename"),
					uuid: jobj.data("uuid"),
					uploadPath: jobj.data("path"),
					fileType: jobj.data("type")
			};
			arr.push(data);
		})
		console.log(modalInputReplyerNick.val())
		var reply={
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				replyerNick: modalInputReplyerNick.val(),
				bno: bnoValue,
				attachList: arr
		};
		replyService.add(reply, function(result){
			//alert(result);
			modal.find('input').val('');
			modal.modal('hide');
			showList(-1);
		})
	});
	//Read
	$('.chat').on('click','li',function(e){
		var rno=$(this).data('rno');
		
		replyService.get(rno,function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyerNick.val(reply.replyerNick);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr('readonly','readonly');
			modal.data('rno',reply.rno);
			
			modal.find('button').hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			modalCloseBtn.show();
			$('.reply_modal').modal('show');
		})
	})
	//update
	modalModBtn.on('click',function(e){
		var originalReplyer = modalInputReplyer.val();//작성자
		if(!replyer){
			alertify.alert('로그인 후 가능합니다');
			$('.modal').modal('hide');
			return;
		}
		if(replyer != originalReplyer){
			alertify.alert('자신이 작성한 댓글만 가능합니다');
			$('.modal').modal('hide');
			return;
		}
		var reply={
				rno: modal.data('rno'),
				reply: modalInputReply.val(),
				replyer: originalReplyer
		};
		replyService.update(reply, function(result){
			//alert(result);
			modal.modal('hide');
			showList(pageNum);
		})
	});
	//Delete
	modalRemoveBtn.on('click',function(e){
		var rno = modal.data('rno');
		if(!replyer){
			alertify.alert('로그인 후 삭제 가능합니다');
			$('.modal').modal('hide');
			return;
		}
		var originalReplyer = modalInputReplyer.val();//작성자
		if(replyer != originalReplyer){
			alertify.alert('자신이 작성한 댓글만 삭제 가능합니다');
			$('.modal').modal('hide');
			return;
		}
		replyService.remove(rno, originalReplyer, function(result){
			//alert(result);
			modal.modal('hide');
			showList(pageNum);
		})
	});

});

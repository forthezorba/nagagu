$(document).ready(function(){
	//리플 출력
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
				return;
			}
			if(list==null || list.length == 0){
				replyUL.html("");
				return;
			}
			var str='';
			
			for(var i=0, len=list.length||0; i<len; i++){
				var imgs ='';
				$.ajaxSetup({ async: false });
				$.getJSON("/replies/getAttachListByRno",{rno: list[i].rno}, function(arr){
					$(arr).each(function(j,attach){
						//var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
						imgs += "<img src='"+attach.url+"'>"
					})
				})
				str += "<li class='left clearfix' data-rno='"+list[i].rno+"' data-replyer='"+list[i].replyer+"'>";
				str += "	<div><div class='header'><strong class='primary-font'>"+list[i].replyerNick+"</strong>";
				str += "		<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str += "		<p id='star_grade'>"
				for(var j=0, grade=list[i].grade||5; j<grade; j++){
					str += '<a href="#" class="on">★</a>'
				}
				for(var k=0, grade=list[i].grade||5; k<5-grade; k++){
					str += '<a href="#">★</a>'
				}
				str += "		</p>"
				str += "		<p>"+imgs+"</p>";	
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
		console.log('repage')
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
		var str = "<ul class='pagination pt-4 pull-right'>";
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
	var modalInputGrade = modal.find("input[name='grade']");
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
		$('.uploadResult ul').html('');
		$('.reply_modal').modal('show');
		$('.reply_modal #star_grade').children("a").removeClass("on");
	});
	
 	//등록
	modalRegisterBtn.on('click',function(e){
		var arr= [];
		var grade = $('.modal #star_grade .on').length;
		
		$('.uploadResult ul li').each(function(i,obj){
			var jobj = $(obj);
			var data = {
					url: jobj.data("url"),
					fileName: jobj.data("filename"),
					uuid: jobj.data("uuid"),
					uploadPath: jobj.data("path"),
					fileType: jobj.data("type")
			};
			arr.push(data);
		})
		
		var reply={
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				replyerNick: modalInputReplyerNick.val(),
				bno: bnoValue,
				grade: grade,
				attachList: arr
		};
		replyService.add(reply, function(result){
			//alert(result);
			modal.find('input').val('');
			$('.uploadResult ul').html('');
			modal.modal('hide');
			showList(-1);
		})
	});
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
		//삭제되지 않은 list
		var arr= [];
		$('.uploadResult ul li').each(function(i,obj){
			var jobj = $(obj);
			var data = {
					url: jobj.data('url'),
					fileName: jobj.data("filename"),
					uuid: jobj.data("uuid"),
					uploadPath: jobj.data("path"),
					fileType: jobj.data("type")
			};
			arr.push(data);
		})
		var reply={
				rno: modal.data('rno'),
				reply: modalInputReply.val(),
				replyer: originalReplyer,
				replyerNick: modalInputReplyerNick.val(),
				attachList: arr
		};
		replyService.update(reply, function(result){
			console.log(result);
			modal.find('input').val('');
			$('.uploadResult ul').html('');
			modal.modal('hide');
			showList(pageNum);
		})
	});
	
	//Read
	$('.chat').on('click','li',function(e){
		var rno=$(this).data('rno');
		var OriginReplyer=$(this).data('replyer');//원댓글 작성자
		var str = $(this).find('#star_grade').html();
		$('.bigPicture').html('');//모달창 안 원본사진 전에 눌렀다면 초기화
		
		replyService.get(rno,function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyerNick.val(reply.replyerNick);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr('readonly','readonly');
			$('.modal #star_grade').html(str);
			modal.data('rno',reply.rno);
			modal.find('button').hide();
			modalInputReplyDate.closest('div').hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			modalCloseBtn.show();

			if(replyer == OriginReplyer){
				modal.find('.panel-heading').show();
			}
			$('.reply_modal').modal('show');
			getAttachList(reply.rno);
		})
	})
	//사진파일 모달창에 출력하기
	function getAttachList(rno){
		$.getJSON("/replies/getAttachListByRno",{rno: rno}, function(arr){
			console.log(arr);
			var str='';
			$(arr).each(function(i,attach){
				if(attach.fileType){
					//var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					str += "<li data-path='"+attach.uploadPath+"' data-url='"+attach.url+"'";
					str += " data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" 
					str += '<div>';
					str += '<button type="button" data-url="'+attach.url+'" data-type="image" class="btn btn-warning btn-circle btn-xs"><i class="fa fa-times"></i></button><br>';
					str += "<img src='"+attach.url+"' data-toggle='modal' data-target='#imgModal'>"
					str += '</div></li>';
				}
			})
			$('.uploadResult ul').html(str);
			$('.uploadResultCopy ul').html(str);
		});
	}
	
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

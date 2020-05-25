$(document).ready(function() {
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	//써머노트
	$('.summernote').summernote({
		width: 1000,
		height: 250,
		lang: 'ko-KR', 
		callbacks: {
			  onImageUpload: function(files) {
				  sendFile(files,this);
			  },
			  onMediaDelete: function (target) {
	              deleteFile (target[0].src, target[0].dataset["filename"]);
			  }
		  }
	});
	function sendFile(files,editor) {
		var formData = new FormData();
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("data",files[i]);
		}
		formData.append("category",'store');
		$.ajax({
			url: '/uploadAWS',
			processData: false,
			contentType: false,
			data: formData,
			type: 'post',
			dataType: 'json',
			success: function(result){
				var editorName = $(editor).attr('name');
				//사진 정보 생성(show)
				showUploadedFile(result,editorName);
				//summernote 이미지 출력
				$(result).each(function(i,obj){
					/*if(obj.image){
						var fileCallPath = '/communityupload/image/'+obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
					}*/
					//input name으로 구분해서 이미지 삽입(써머노트 안)
					
					console.log('editname'+editorName);
					if(editorName != ''){
						$('#'+editorName).summernote('editor.insertImage', obj.url, obj.uuid, obj.fileName);
						return;
					}
					$('.summernote').summernote('editor.insertImage', obj.url, obj.uuid, obj.fileName);
				})
			}
		});
	}
	
	//파일 ajax
	$('input[type="file"]').change(function(e){
		console.log('input file change');
		var formData = new FormData();
		var inputFile=$(this);
		var inputName = $(this).attr('name');
		var files=inputFile[0].files;
		var category = 'store';
		console.log(inputName);
		//main이미지는 하나만(초기화)
		if(inputName==='uploadFile'){
			category='reply';
		}
		if(inputName==='mainImage'){
			$('.uploadResultMain ul').empty();
		}
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("data",files[i]);
		}
		formData.append("category",category);
		$.ajax({
			url: '/uploadAWS',
			processData: false,
			contentType: false,
			enctype: "multipart/form-data",
			data: formData,
			type: 'post',
			dataType: 'json',
			success: function(result){
				console.log('ajax..'+result);
				showUploadedFile(result,inputName)						
			}
		});
	})
	//파일삭제
	function deleteFile (src, uuid) {
		$.ajax({
			url: '/deleteAWS',
			data: {fileName:src},
			type: 'post',
			success: function(result){
				$('ul').find("li[data-uuid='"+uuid+"']").remove();
			}
		});
	}
	//파일 체크
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	function checkExtension(fileName, fileSize){
		if(fileSize>=maxSize){
			alertify.alert('파일 크기 초과');
			return false;
		}
		if(regex.test(fileName)){
			alertify.alert('해당 종류의 파일은 업로드 할 수 없습니다')
			return false;
		}
		return true;
	} 
	//submit -> attachList[] append(파일객체 DB저장)
	var formObj = $('form[role=form]');
	$('button[type="submit"]').on('click',function(e){
		e.preventDefault();
		var operation=$(this).data('oper');
		if(operation==='remove'){
			formObj.attr('action','/store/remove');
		}else if(operation==='list'){
			formObj.attr('action','/store/list').attr('method','get');
			formObj.empty();
		}else if(operation === 'register'){
			
			var str='';
			//기존 store-get-reply용
			$('.uploadResult ul li').each(function(i,obj){
				var jobj = $(obj);
				str += "<input type='hidden' name='attachList["+i+"].url' value='"+jobj.data("url")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			})
			//배너이미지
			var banner='';
			$('.uploadResultBanner ul li').each(function(i,obj){
				var jobj = $(obj);
				str += "<input type='hidden' name='attachList["+(i+1)+"].url' value='"+jobj.data("url")+"'>";
				str += "<input type='hidden' name='attachList["+(i+1)+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+(i+1)+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+(i+1)+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+(i+1)+"].fileType' value='"+jobj.data("type")+"'>";
				
				//var fileCallPath = encodeURIComponent(jobj.data("path")+"/s_"+jobj.data("uuid")+"_"+jobj.data("filename"));
				var fileCallPath = jobj.data("url");
				banner += fileCallPath+',';
			})
			$('.banner').html('<input type="hidden" name="banner" value="'+banner+'">')//ProductVO DB저장
			
			//메인이미지(db저장용)-
			var obj = $('.uploadResultMain ul li');
			var jobj = $(obj);
			//var fileCallPath = encodeURIComponent(jobj.data("path")+"\/\s_"+jobj.data("uuid")+"_"+jobj.data("filename"));
//			$('.mainImage').html('<input type="text" name="mainImage" value="'+jobj.data("path")+"\/\s_"+jobj.data("uuid")+"_"+jobj.data("filename")+'">');//ProductVO DB저장
			$('.mainImage').html('<input type="hidden" name="mainImage" value="'+jobj.data("url")+'">');//ProductVO DB저장
			str += "<input type='hidden' name='attachList[0].url' value='"+jobj.data("url")+"'>";
			str += "<input type='hidden' name='attachList[0].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList[0].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList[0].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList[0].fileType' value='"+jobj.data("type")+"'>";
			formObj.append(str).submit();	
		}
		formObj.submit();
	})
	//업로드파일 show
	function showUploadedFile(uploadResultArr,inputName){
		var str='';
		if(!uploadResultArr || uploadResultArr.length==0){return;}
		$(uploadResultArr).each(function(i,obj){
			console.log('show obj...'+JSON.stringify(obj))
			
			if(obj.image){
				//var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-url='"+obj.url+"'";
				if(inputName==='mainImage'){
					str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='false'>" //mainImage는 type=false로 set
				}else{
					str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>"
				}
				str += '<div>';
				/*var fileName= obj.uuid+obj.fileName;
				if(fileName.length > 10){
		          fileName = fileName.substring(0,7)+"...";
		        }
				str += '<span>'+fileName+'</span>';*/
				str += '<button type="button" data-url="'+obj.url+'" data-type="image" class="btn btn-warning btn-circle btn-xs"><i class="fa fa-times"></i></button><br>';
				str += "<img src='"+obj.url+"'>"
				str += '</div></li>';
			}
		});
		console.log(inputName); 
		if(inputName === 'mainImage'){
			$('.uploadResultMain ul').append(str);//store-regi/modi
			return;
		}if(inputName === 'banner'){
			$('.uploadResultBanner ul').append(str);//store-regi/modi
			return;
		}
		if(inputName === 'shipInfo' || inputName === 'content'){
			$('.uploadResult ul').append(str).hide();//store-regi/modi
			return;
		}
		$('.uploadResult ul').append(str);//기존 store-get-reply
	}
	//파일삭제(화면상에서만 지운다, submit하지 않으면 기존 데이터 보관)
	$('.uploadResult').on('click','button',function(e){
		e.stopPropagation();
		$(this).parent().parent().remove(); 
	});
	$('.uploadResultMain').on('click','button',function(e){
		$(this).parent().parent().remove();
	});
	$('.uploadResultBanner').on('click','button',function(e){
		$(this).parent().parent().remove();
	});
});

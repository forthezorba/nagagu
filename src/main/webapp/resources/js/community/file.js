/* 썸머노트 부분 */
$(document).ready(function() {
	$('#summernote').summernote({
		width: 1000,
		height: 500,
		lang: 'ko-KR', 
		callbacks: {
			  onImageUpload: function(files) {
				  console.log(files);
				  //sendFile(files[0]);
				  sendFile(files);
			  },
			  onMediaDelete: function (target) {
				  console.log(target);
				  console.log(target[0]);
	                deleteFile (target[0].src, target[0].dataset["filename"]);
			  }
		  }
	});
	
	//파일 ajax
	function sendFile(files) {
		var formData = new FormData();
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("data",files[i]);
			//formData.append("uploadFile",files[i]);
		}
		console.log(formData);
		
		formData.append("category",'cm');
		$.ajax({
			url: '/uploadAWS',
			processData: false,
			contentType: false,
			data: formData,
			type: 'post',
			dataType: 'json', 
			enctype: "multipart/form-data",
			success: function(result){
				//li에 사진 정보 생성(attachList)
				showUploadedFile(result);
				//summernote 이미지 출력
				$(result).each(function(i,obj){
	        		var fileCallPath = obj;
	        		$('#summernote').summernote('editor.insertImage', obj.url, obj.uuid, obj.fileName);
	        	})
/*				$(result).each(function(i,obj){
					if(obj.image){
						var fileCallPath = '/communityupload/image/'+obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
					}
					$('#summernote').summernote('editor.insertImage', fileCallPath, obj.uuid);
				})
*/			}
		});
	}
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	function checkExtension(fileName, fileSize){
		if(fileSize>=maxSize){
			alert('파일 크기 초과');
			return false;
		}
		if(regex.test(fileName)){
			alert('해당 종류의 파일은 업로드 할 수 없습니다')
			return false;
		}
		return true;
	} 
	
	//파일 show
	function showUploadedFile(uploadResultArr){
		var str='';
		if(!uploadResultArr || uploadResultArr.length==0){return;}
		var uploadUL = $('.uploadResult ul');
		$(uploadResultArr).each(function(i,obj){
			console.log(obj)
			if(obj.image){
				str += "<li data-url='"+obj.url+"' data-path='"+obj.uploadPath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>" 
				str += '</li>';
			}
		});
		uploadUL.append(str);
		//$('.uploadResult ul').hide();
	}
	//파일삭제
	function deleteFile (src, uuid) {
		console.log(src);
		//var changedSrc = src.replace(uuid,"s_"+uuid);
		$.ajax({
			url: '/deleteAWS',
			data: {fileName:src},
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			}, 
			type: 'post',
			success: function(result){
				alert(result);
				$('ul').find("li[data-uuid='"+uuid+"']").remove();
			}
		});
	}
});

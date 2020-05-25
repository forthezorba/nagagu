<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <title> SpringBoot & AWS S3</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script
        src="https://code.jquery.com/jquery-3.3.1.js"
        integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<h1>
    S3 이미지 업로더
</h1>
<div class="col-md-12">
    <div class="col-md-2">
        <form enctype="mutipart/form-data">
            <div class="form-group">
                <label for="img">파일 업로드</label>
                <input type="file" id="img" multiple="multiple">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </div>
            <button type="button" class="btn btn-primary" id="btn-save">저장</button>
        </form>
    </div> 
    <div class="col-md-10">
        <p><strong>결과 이미지입니다.</strong></p>
        <img src="" id="result-image">
        <div class="uploadResult">
        </div>
    </div>
</div>


<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ajaxSend(function(e,xhr,options){
		console.log(csrfHeaderName, csrfTokenValue);
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
    $('#btn-save').on('click', uploadImage);
 
    function uploadImage() {
        var files = $('#img')[0].files;
        var formData = new FormData();
        
        for(var i=0; i<files.length; i++){
			formData.append("data",files[i]);
		}
        
        //formData.append('data', files);

        $.ajax({
            type: 'POST',
            url: '/uploadAWS',  
            data: formData, 
            dataType: 'json',
            processData: false,
            contentType: false
        }).done(function (data) {
        	console.log(data);
        	var str='';
        	$(data).each(function(i,obj){
        		str += "<img src="+obj+">"
        	})
//            $('#result-image').attr("src", data);
            $('.uploadResult').append(str);
        }).fail(function (error) {
            alert(error);
        })
    }
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상세보기</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .detail-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 50px;
        }
        .table-detail {
            margin-bottom: 20px;
        }
        .table-detail th {
            background-color: #f8f9fa;
            width: 20%;
        }
        .comment-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }
        .comment-item {
            border-bottom: 1px solid #e9ecef;
            padding: 10px 0;
        }
        .dropdown-menu {
            min-width: 100px;
        }
    </style>
    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="/WEB-INF/jsp/common/sidebar.jsp" %>

    <script>
        $(document).ready(function() {
            if (${rq.getLoginedMemberId() != -1 }) {
                getLoginId();
            }
        })
        
        const getLoginId = function() {
            $.ajax({
                url : '/usr/member/getLoginId',
                type : 'GET',
                dataType : 'text',
                success : function(data) {
                    $('#loginedMemberLoginId').html(data);
                },
                error : function(xhr, status, error) {
                    console.log(error);
                }
            })
        }
        
        let originalForm = null;
        let originalId = null;
        
        const replyModifyForm = function(i, body) {
            if (originalForm != null) {
                replyModifyCancle(originalId);
            }
            
            let replyForm = $('#' + i);
            originalForm = replyForm.html();
            originalId = i;
            
            let addHtml = `
                <form action="/usr/reply/doModify" method="post" onsubmit="replyForm_onSubmit(this); return false;">
                    <input type="hidden" name="id" value="\${i}" />
                    <input type="hidden" name="relId" value="${article.getId() }" />
                    <div class="border rounded-xl p-4 mt-2">
                        <div id="loginedMemberLoginId" class="mt-3 mb-2 fw-semibold"></div>
                        <textarea style="resize:none;" class="form-control" name="body">\${body }</textarea>
                        <div class="d-flex justify-content-end mt-2">
                            <button onclick="replyModifyCancle(\${i});" type="button" class="btn btn-secondary me-2">취소</button>
                            <button class="btn btn-primary">수정</button>
                        </div>
                    </div>
                </form>`;
            
            replyForm.html(addHtml);
            getLoginId();
        }
        
        const replyModifyCancle = function(i) {
            let replyForm = $('#' + i);
            replyForm.html(originalForm);
            originalForm = null;
            originalId = null;
        }
    </script>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 detail-container">
                <table class="table table-bordered table-detail">
                    <tr>
                        <th>no</th>
                        <td>${article.getId() }</td>
                    </tr>
                    <tr>
                        <th>작성날짜</th>
                        <td>${article.getRegDate().substring(2, 16) }</td>
                    </tr>
                    <tr>
                        <th>수정날짜</th>
                        <td>${article.getUpdateDate().substring(2, 16) }</td>
                    </tr>
                    <tr>
                        <th>조회수</th>
                        <td>${article.getViews() }</td>
                    </tr>
                    <tr>
                        <th>ID</th>
                        <td>${article.getLoginId() }</td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>${article.getTitle() }</td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>${article.getBody() }</td>
                    </tr>
                </table>
                
                <div class="d-flex justify-content-between align-items-center my-3">
                    <div>	
                        <button class="btn btn-secondary" onclick="history.back();">뒤로가기</button>               
                    </div>
                    
                    <c:if test="${rq.getLoginedMemberId() == article.getMemberId() }">
                        <div>
                            <a class="btn btn-primary me-2" href="modify?id=${article.getId() }">수정</a>
                            <a class="btn btn-danger" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="doDelete?id=${article.getId() }">삭제</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script>
        const replyForm_onSubmit = function(form) {
            form.body.value = form.body.value.trim();
            
            if (form.body.value.length == 0) {
                alert('내용이 없는 댓글은 작성할 수 없습니다');
                form.body.focus();
                return;
            }
            
            form.submit();
        }
    </script>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-10 comment-section">
                <c:if test="${not empty replies }">
                    <div>
                        <h5 class="fw-semibold mb-4">댓글</h5>
                        <c:forEach var="reply" items="${replies }">
                            <div id="${reply.getId() }" class="comment-item">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="fw-semibold">${reply.getLoginId() }</div>
                                    <c:if test="${rq.getLoginedMemberId() == reply.memberId }">
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                <i class="bi bi-three-dots"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><button class="dropdown-item" onclick="replyModifyForm(${reply.getId() }, '${reply.getBody() }');">수정</button></li>
                                                <li><a class="dropdown-item" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="/usr/reply/doDelete?id=${reply.getId() }&relId=${article.getId() }">삭제</a></li>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="mb-1">${reply.getForPrintBody() }</div>
                                <small class="text-muted">${reply.getRegDate() }</small>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                
                <c:if test="${rq.getLoginedMemberId() != -1 }">
                    <form action="/usr/reply/doWrite" method="post" onsubmit="replyForm_onSubmit(this); return false;">
                        <input type="hidden" name="relTypeCode" value="article" />
                        <input type="hidden" name="relId" value="${article.getId() }" />
                        <div class="border rounded-xl p-4 mt-4">
                            <div id="loginedMemberLoginId" class="mt-3 mb-2 fw-semibold"></div>
                            <textarea style="resize:none;" class="form-control" name="body" placeholder="댓글을 작성하세요..."></textarea>
                            <div class="d-flex justify-content-end mt-2">
                                <button class="btn btn-primary">작성</button>
                            </div>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</body>
</html>
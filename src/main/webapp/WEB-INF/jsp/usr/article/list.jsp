<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ include file="/WEB-INF/jsp/common/sidebar.jsp"%>

<c:set var="pageTitle" value="${board.getName() } 게시판" />

<section class="min-h-screen flex items-center justify-center pt-12">
    <div class="container mx-auto bg-white shadow-lg rounded-lg p-8 w-full sm:w-9/12 md:w-8/12 lg:w-7/12 xl:w-6/12">
        <div class="text-center mb-6">
            <h2 class="text-3xl font-semibold text-gray-800">${board.getName()} 게시판</h2>
            <p class="text-sm text-gray-500">총 : ${articlesCnt }개</p>
        </div>

        <table class="table-auto w-full text-left text-sm text-gray-700 mb-4">
            <thead>
                <tr>
                    <th class="px-4 py-2 border-b">번호</th>
                    <th class="px-4 py-2 border-b">제목</th>
                    <th class="px-4 py-2 border-b">작성자</th>
                    <th class="px-4 py-2 border-b">작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="article" items="${articles }">
                    <tr class="hover:bg-gray-100">
                        <td class="px-4 py-2 border-b">${article.getId() }</td>
                        <td class="px-4 py-2 border-b"><a href="detail?id=${article.getId() }" class="text-blue-500 hover:underline">${article.getTitle() }</a></td>
                        <td class="px-4 py-2 border-b">${article.getLoginId() }</td>
                        <td class="px-4 py-2 border-b">${article.getRegDate().substring(2,16) }</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${rq.getLoginedMemberId() != -1 }">
            <div class="flex justify-end my-3">
                <a class="btn btn-primary btn-sm px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700" href="write">글쓰기</a>
            </div>
        </c:if>

        <div class="mt-4 flex justify-center">
            <div class="flex items-center space-x-2">
                <c:set var="path" value="?boardId=${board.getId() }" />
            
                <c:if test="${from != 1 }">
                    <a class="btn btn-sm px-3 py-1 bg-gray-200 text-gray-700 rounded hover:bg-gray-300" href="${path }&cPage=1"><i class="fa-solid fa-angles-left"></i></a>
                    <a class="btn btn-sm px-3 py-1 bg-gray-200 text-gray-700 rounded hover:bg-gray-300" href="${path }&cPage=${from - 1 }"><i class="fa-solid fa-angle-left"></i></a>
                </c:if>
                
                <c:forEach var="i" begin="${from }" end="${end }">
                    <a class="btn btn-sm px-3 py-1 ${cPage == i ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'} rounded hover:bg-gray-300" href="${path }&cPage=${i }">${i }</a>
                </c:forEach>
                
                <c:if test="${end != totalPagesCnt }">
                    <a class="btn btn-sm px-3 py-1 bg-gray-200 text-gray-700 rounded hover:bg-gray-300" href="${path }&cPage=${end + 1 }"><i class="fa-solid fa-angle-right"></i></a>
                    <a class="btn btn-sm px-3 py-1 bg-gray-200 text-gray-700 rounded hover:bg-gray-300" href="${path }&cPage=${totalPagesCnt }"><i class="fa-solid fa-angles-right"></i></a>
                </c:if>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
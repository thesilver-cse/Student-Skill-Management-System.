<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="footer-custom mt-auto">
    <div class="container text-center">
        <p class="mb-1">
            <strong>SkillTrack</strong> — Student Skill Management System
        </p>
        <p class="text-muted mb-0 small" 
           style="cursor: pointer; user-select: none;" 
           title="Double-click to open Viva & Exam Preparation Guide"
           ondblclick="window.location.href='${pageContext.request.contextPath}/viva.jsp';">
            Advanced Java Technology Academic Project &bull; JSP &bull; Servlet &bull; JavaBean &bull; JDBC &bull; MySQL
        </p>
    </div>
</footer>

<!-- Bootstrap 5 Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom Application Script -->
<script src="${pageContext.request.contextPath}/js/script.js"></script>

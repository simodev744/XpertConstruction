<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="bg-gray-800 text-white py-6">
         <div class="rounded-xl flex justify-center align-center">
             <img src="<%=request.getContextPath()%>/views//includes/logo.PNG" width="100" height="100" alt="logo">
         </div>
        <div class="mt-8 border-t border-gray-700 pt-4 text-center text-gray-400">
            © <%= new java.util.Date().getYear() + 1900 %> XpertConstruction. Tous droits réservés. 
        </div>
</footer>
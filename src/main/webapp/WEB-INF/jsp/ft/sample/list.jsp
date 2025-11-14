<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    axios.get("/api/v1/ft/sample/list").then((res) => {
        console.log(res);
    }).catch((error) => {
        console.log(error);
    });
</script>
list
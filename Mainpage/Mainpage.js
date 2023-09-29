$(function() {
    function getServerStatus(){
        const apiUrl = "https://wiki.shangxiaoguan.top/api.php?action=lindongrequest&address=ld.cmsy.xyz&port=19132&format=json";
        
        $.get(apiUrl)
        .done(function(data) {
            if (data.lindongrequest.status == "online") {
                const { online, max } = data.lindongrequest;
                $("#online-player").text(`${online}/${max}`);
                $("#online-ver").text('Ver ' + data.lindongrequest.version);
                $("#online-desc").text('服务器已启动。延迟 ' + data.lindongrequest.delay + ' 毫秒。');
            } else {
                $("#online-player").text("-/-");
                $("#online-desc").text('服务器未启动。');
            }
        })
        .fail(function(error) {
            $("#online-player").text("-/-");
            $("#online-desc").text('无法发送请求，请检查当前设备网络。');
        });
    }

    getServerStatus();
    setInterval(getServerStatus, 3 * 60 * 1000);
}());
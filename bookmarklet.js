javascript : void((function () {
	let iddecomptea = document.querySelectorAll('[data-account]')[0];
	if (iddecomptea === undefined){
        var iddecompte = document.querySelectorAll('[accountid]')[0].getAttribute("accountid");
    } else {
        var iddecompte = iddecomptea.getAttribute("data-account");
    }
    let iddevideo = document
        .querySelectorAll('[data-video-id]')[0]
        .getAttribute("data-video-id");
    let urldevideo = "http://players.brightcove.net/" + iddecompte + "/default_default/index.html?videoId=" + iddevideo;
    alert('youtube-dl --write-info-json ' + urldevideo + '\r\n\r\nURL:\r' + urldevideo);
})())

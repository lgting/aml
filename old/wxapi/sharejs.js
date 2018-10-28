
shareLink = 'http://www.jubenxiong.com';
shareimgUrl = 'http://www.jubenxiong.com/wxapi/loge.jpg';
shareDesc = '巨本熊工作室出品';
sharetitle = '巨本熊工作室';


function SetShareMsg(slink,simgurl,sdesc,stitle){
	if(slink!='')
		shareLink = slink;
	
	if(simgurl!='')
		shareimgUrl = simgurl;
	
	if(sdesc!='')
		shareDesc = sdesc;
	
	if(stitle!='')
		sharetitle = stitle;
	
	GetUrlData();
}


function GetUrlData(){
	var sendDb = {
		urls:toShreUrl
	};
	
	jQuery.post("http://www.jubenxiong.com/wxapi/share.php",sendDb,function (msgs) {          
		console.log("res=" + msgs);
		var wxobjs = JSON.parse(msgs);
		var wxob={};
		wxob.timestamp = wxobjs.timestamp;
		wxob.nonceStr = wxobjs.nonceStr;
		wxob.signature = wxobjs.signature;//'<?php echo $signPackage["signature"];?>';
		wxob.link = shareLink;
		wxob.imgUrl = shareimgUrl;
		wxob.title= sharetitle;
		wxob.desc= shareDesc;
		setData(wxob);		
	});
}



function setData(obj){ 
wx.config({
		debug: false,
		appId: "wx7d05a96d073b899b",
		timestamp: obj.timestamp,
		nonceStr: obj.nonceStr,
		signature: obj.signature,
		jsApiList: [
		  // 所有要调用的 API 都要加到这个列表中
		  "onMenuShareTimeline",
		  "onMenuShareAppMessage",
		  "onMenuShareQQ",
		  "onMenuShareWeibo",
		  "onMenuShareQZone",
		  "chooseImage",
		  "uploadImage",
		  "downloadImage",
		  "checkJsApi", 
		  "scanQRCode"
		]
	  });
	  wx.ready(function () {
		// 在这里调用 API
		wx.onMenuShareTimeline({

		title: sharetitle, // 分享标题
		
		//desc: shareDesc, // 分享描述
		
		link: shareLink, // 分享链接

		imgUrl: shareimgUrl, // 分享图标

		success: function () { 

			// 用户确认分享后执行的回调函数
			//console.log("im ok");
		},

		cancel: function () { 

			// 用户取消分享后执行的回调函数
			//console.log("im fail");
		}
		});

		wx.onMenuShareAppMessage({

		title: sharetitle, // 分享标题

		desc: shareDesc, // 分享描述

		link: shareLink, // 分享链接

		imgUrl: shareimgUrl, // 分享图标

		type: '', // 分享类型,music、video或link，不填默认为link

		dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空

		success: function () { 

			// 用户确认分享后执行的回调函数

		},

		cancel: function () { 

			// 用户取消分享后执行的回调函数

		}
	});
	
	wx.onMenuShareQQ({

    title: sharetitle, // 分享标题

    desc: shareDesc, // 分享描述

    link: shareLink, // 分享链接

    imgUrl: shareimgUrl, // 分享图标

    success: function () { 

       // 用户确认分享后执行的回调函数

    },

    cancel: function () { 

       // 用户取消分享后执行的回调函数

    }
	});
	
	//微博
	wx.onMenuShareWeibo({

    title: sharetitle, // 分享标题

    desc: shareDesc, // 分享描述

    link: shareLink, // 分享链接

    imgUrl: shareimgUrl, // 分享图标

    success: function () { 

       // 用户确认分享后执行的回调函数

    },

    cancel: function () { 

        // 用户取消分享后执行的回调函数

    }
	});
	
	wx.onMenuShareQZone({

    title: sharetitle, // 分享标题

    desc: shareDesc, // 分享描述

    link: shareLink, // 分享链接

    imgUrl: shareimgUrl, // 分享图标

    success: function () { 

       // 用户确认分享后执行的回调函数

    },
    cancel: function () { 
        // 用户取消分享后执行的回调函数
    }
	});
	
	wx.checkJsApi({  
		jsApiList : ['scanQRCode'],  
		success : function(res) {  
		}  
	});
	
	
	});
	
  
	wx.error(function(res){
		//console.log("res=".res);
		alert('error='+res)
	});
}

function selectImage(){
	//alert('111');
	wx.ready(function () {
		wx.chooseImage({
			sourceType: ['camera'],
			success: function (res) {
				//echo "res=".res.localIds;
				//images.localId = res.localIds;
				//alert('已选择 ' + res.localIds.length + ' 张图片');
				//$(obj).attr("src", res.localIds[0]);
				//alert("|" + $(obj).attr("src") + "|");
				var localIds = res.localIds;
				alert('已选择 ' + localIds + ' 张图片');
				
		    var imags = { 
				localId: [], 
				serverId: [],
				loadbackid:[]
            };
				imags.localId = res.localIds;
				uploadimage(imags);
				return imags;
			}
		})
	});

	wx.error(function(res){
		alert('err='+res);
	});
	
}

var loadimageid = [];

function uploadimage(imags){ 

	alert("imng="+imags.localId.length);
	var i = 0, 
	length = imags.localId.length; 
	loadimageid = [];
	function upload(){ 
		wx.uploadImage({ 
			localId: imags.localId[i], 
			success: function (res) { 
				i++; 
				imags.serverId = res.serverId; 
				//download(imags); 
				downPic(res.serverId,imags);
				if (i < length) { 
					upload(); 
				} 
				loadimageid[i] = res.serverId;
				alert("ok="+res.serverId);
			}, 

			fail: function (res) { 
				alert(JSON.stringify(res)); 
			} 
		}); 

	} 
	upload(); 
}


function downPic(sid,imags){
	
	alert("downstart");
	wx.downloadImage({

    serverId:sid, // 需要下载的图片的服务器端ID，由uploadImage接口获得

    isShowProgressTips: 1, // 默认为1，显示进度提示

    success: function (res) {

		alert("downstartok");
        var localId = res.localId; // 返回图片下载后的本地ID
		console.log("locid="+localId);
		//imags.loadbackid[0]=localId;
		//<?php $signPackage->get_material(localId)?>
		location.href = "ph.php?localId="+sid;
    }

});

}



function updateimagefun(localIds){
	
	wx.ready(function () {
		wx.uploadImage({

					localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
					isShowProgressTips: 1, // 默认为1，显示进度提示
					success: function (res) {
						var serverId = res.serverId; // 返回图片的服务器端ID
						alert('已选择 ' + serverId + ' 张图片');
					}

				});
	});
}

function wxscanQRCode(){
	wx.scanQRCode({  
		needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，  
		scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有  
		success : function(res) {  
			var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果  
			//document.getElementById("wm_id").value = result;//将扫描的结果赋予到jsp对应值上  
			alert("扫描成功::扫描码=" + result);  
		}  
	});
}

function setDataBig(obj){
	console.log("c"+obj.appId);
}
var thisVer = "1.30";

function $(e) {
	return document.getElementById(e);
}

function $name(e) {
	return document.getElementsByName(e);
}

function $tag(e) {
	return document.getElementsByTagName(e);
}
var RO_Dir = "";
var cocco_bk_url = "http://cocco.privatemoon.jp/ai/bk/";
var LoadFlag = 0;
var LocalData = false;
var ForReading = 1;
var ForWriting = 2;
var ForAppending = 8;
var strCRLF = "\r\n";
var ImageRoot = "http://lh5.ggpht.com/_8Hzx_QBHnQA/";
var image = [];
image["0"] = ImageRoot + "TBJ1CZkxklI/AAAAAAAAABM/mHAKfFjUP_4/s128/0.gif";
image["1"] = ImageRoot + "TBJ1ChZObVI/AAAAAAAAABQ/uR3rh7px9cE/s128/1.png";
image["2"] = ImageRoot + "TBJ1Cl8OdpI/AAAAAAAAABU/xSe3yFQEpFk/s128/2.png";
image["3"] = ImageRoot + "TBJ1Ct5ERHI/AAAAAAAAABY/U48v1pR6LgY/s128/3.png";
image["4"] = ImageRoot + "TBJ1C_sZ7qI/AAAAAAAAABc/_t-Q4zjoxu4/s128/4.png";
image["5"] = ImageRoot + "TBJ1mxsIOhI/AAAAAAAAACA/NVpzTTsWsEY/s128/5.png";
image["6"] = ImageRoot + "TBJ1nH_zDqI/AAAAAAAAACE/pZOrClNjo3U/s128/6.png";
image["7"] = ImageRoot + "TBJ1nHjAxOI/AAAAAAAAACI/t-K-E5YQUfI/s128/7.png";
image["8"] = ImageRoot + "TBJ1nb5nvLI/AAAAAAAAACM/9QtTUUPw26o/s128/8.png";
image["9"] = ImageRoot + "TBJ1nck1JlI/AAAAAAAAACQ/8Ovk5oENwA8/s128/9.png";
image["10"] = ImageRoot + "TBJ1rLmxTyI/AAAAAAAAACU/CpFSbuHPoi8/s128/10.png";
image["11"] = ImageRoot + "TBJ1rAwgn9I/AAAAAAAAACY/o69hONypnm0/s128/11.png";
image["12"] = ImageRoot + "TBJ1rNgRQtI/AAAAAAAAACc/YEYyBukaN9U/s128/12.png";
image["13"] = ImageRoot + "TBJ1rZTMAGI/AAAAAAAAACg/jxaZvwS994c/s128/13.png";
image["14"] = ImageRoot + "TBJ1rVwZ_UI/AAAAAAAAACk/N0a-7DpjWwo/s128/14.png";
image["15"] = ImageRoot + "TBJ10LiOthI/AAAAAAAAACo/LG-48xIfAm8/s128/15.png";
image["16"] = ImageRoot + "TBJ10K04YTI/AAAAAAAAACs/5R602Cj9JY4/s128/16.png";
image["48"] = "https://lh6.googleusercontent.com/-syq4Ts6pzgk/Tl452qLlq6I/AAAAAAAAAWI/_OOcJ_YIS6o/48.png";
image["49"] = "https://lh3.googleusercontent.com/-sSD0aa-N41o/Tl452S1jz7I/AAAAAAAAAWE/m1Utf9UyN0o/49.png";
image["50"] = "https://lh4.googleusercontent.com/-mWZIBUgIwTI/Tl452apUIlI/AAAAAAAAAWM/ZGQY9DkEWes/50.png";
image["51"] = "https://lh5.googleusercontent.com/-EO7KemY933Y/Tl452klQ3YI/AAAAAAAAAWQ/9uVT7J3amlg/51.png";
image["52"] = "https://lh6.googleusercontent.com/-4iyE454lqVE/Tl452zkoErI/AAAAAAAAAWU/DMwMBHeM-zA/52.png";
image["8001"] = ImageRoot + "TBJ10aUunEI/AAAAAAAAACw/1Zk2HCkSbRE/s128/8001.gif";
image["8002"] = ImageRoot + "TBJ10enZpxI/AAAAAAAAAC0/fK0qL6iIZXU/s128/8002.gif";
image["8003"] = ImageRoot + "TBJ10rV7jNI/AAAAAAAAAC4/heAeBlHpK7E/s128/8003.gif";
image["8004"] = ImageRoot + "TBJ15eI9jDI/AAAAAAAAAC8/rxZYmjGY5MU/s128/8004.gif";
image["8005"] = ImageRoot + "TBJ15R-LGdI/AAAAAAAAADA/J7bwuwaWQEY/s128/8005.gif";
image["8006"] = ImageRoot + "TBJ15ixvoDI/AAAAAAAAADE/HCDwx7DLvJU/s128/8006.gif";
image["8007"] = ImageRoot + "TBJ15q2TCAI/AAAAAAAAADI/O4OV-dUzWGo/s128/8007.gif";
image["8008"] = ImageRoot + "TBJ16HgCGjI/AAAAAAAAADM/y2azirg5TeY/s128/8008.gif";
image["8009"] = ImageRoot + "TBJ1_ZJ0M4I/AAAAAAAAADQ/mIVJN87Y9iU/s128/8009.gif";
image["8010"] = ImageRoot + "TBJ1_ZnUM8I/AAAAAAAAADU/zcpu4b4tekk/s128/8010.gif";
image["8011"] = ImageRoot + "TBJ1_W9ydwI/AAAAAAAAADY/frwEtWfssAY/s128/8011.gif";
image["8012"] = ImageRoot + "TBJ1_sV0GCI/AAAAAAAAADc/hk3owcFNqww/s128/8012.gif";
image["8013"] = ImageRoot + "TBJ1_k45-tI/AAAAAAAAADg/0qu5ia4bvlo/s128/8013.gif";
image["8014"] = ImageRoot + "TBJ2cqGDhCI/AAAAAAAAADk/F44ZfcwZABU/s128/8014.gif";
image["8015"] = ImageRoot + "TBJ2c2dNVHI/AAAAAAAAADo/Yv9fVxeSY6g/s128/8015.gif";
image["8016"] = ImageRoot + "TBJ2c6V3lpI/AAAAAAAAADs/-lVzUJmLCnY/s128/8016.gif";
image["8017"] = "8017";
image["8018"] = "https://lh6.googleusercontent.com/-bHSKlwcLAr8/Tlml1nxiyaI/AAAAAAAAAUU/3wVnGHkr75g/8018.gif";
image["8019"] = "https://lh6.googleusercontent.com/-xL6hyAvO4pM/Tlml11utB5I/AAAAAAAAAUY/qO-l9Xm_iwU/8019.gif";
image["8020"] = "https://lh3.googleusercontent.com/-rpHdzdBOFxI/Tlml1_FukGI/AAAAAAAAAUc/ROSG5nNwU_s/8020.gif";
image["8021"] = "https://lh3.googleusercontent.com/-Pb5423guHbc/Tlml12kqGDI/AAAAAAAAAUg/tw0VqyLgH0c/8021.gif";
image["8022"] = "https://lh3.googleusercontent.com/-gnPzwRYkij8/Tlml2HOp_rI/AAAAAAAAAUk/gGIO1T0zL7A/8022.gif";
image["8023"] = "https://lh3.googleusercontent.com/-ZaZ_kcI5LTM/Tlml2DoViHI/AAAAAAAAAUo/RlShuzMrJrQ/8023.gif";
image["8024"] = "https://lh4.googleusercontent.com/-cAPzuvYL23Y/Tlml2MPWf7I/AAAAAAAAAUs/drRKPwFl0RE/8024.gif";
image["8025"] = "https://lh5.googleusercontent.com/-XU8ywUULsn0/Tlml2QCmUdI/AAAAAAAAAUw/QOF2i2N6ZBA/8025.gif";
image["8026"] = "https://lh5.googleusercontent.com/-71mp4yAgEEs/Tlml2UeuW5I/AAAAAAAAAU0/HVg7DWrtRDo/8026.gif";
image["8027"] = "https://lh6.googleusercontent.com/-pBunPXjclmY/Tlml2Q6narI/AAAAAAAAAU4/i9svNcCNbRA/8027.gif";
image["8028"] = "https://lh5.googleusercontent.com/-xjjDFhJnJfs/Tlml2rhJtqI/AAAAAAAAAU8/j8oUxZQiYEw/8028.gif";
image["8029"] = "https://lh5.googleusercontent.com/-Cf8TxRNBrVo/Tlml2nhN4NI/AAAAAAAAAVE/mff_GWLOYiY/8029.gif";
image["8030"] = "https://lh4.googleusercontent.com/-fbTOReX6kWI/Tlml2mVEQbI/AAAAAAAAAVA/hcqGoDosVzg/8030.gif";
image["8031"] = "https://lh3.googleusercontent.com/-ZS2ZTvl8LFA/Tlml2_cu7gI/AAAAAAAAAVI/R22aUCow7jc/8031.gif";
image["8032"] = "https://lh6.googleusercontent.com/-LCwJFhnSXio/Tlml23qp7bI/AAAAAAAAAVM/lsvt5XUCrkM/8032.gif";
image["8033"] = "https://lh5.googleusercontent.com/-FGWnPsw86Y8/Tlml28JoUeI/AAAAAAAAAVQ/XYQ-p-P0ODs/8033.gif";
image["8034"] = "https://lh3.googleusercontent.com/-MLCvT5-Fj04/Tlml3BnhL8I/AAAAAAAAAVc/PvmDpdPJqqg/8034.gif";
image["8035"] = "https://lh5.googleusercontent.com/-r1G3jsNuPb0/Tlml3DJHDFI/AAAAAAAAAVU/ICyDmV0J4Vg/8035.gif";
image["8036"] = "https://lh4.googleusercontent.com/-FrvnvIQz9_c/Tlml3DWuFvI/AAAAAAAAAVY/viaEeKkIYgY/8036.gif";
image["8037"] = "https://lh3.googleusercontent.com/-7L9ri2lhIw0/Tlml3QdwUwI/AAAAAAAAAVg/rQ9G7VbrpWM/8037.gif";
image["8038"] = "https://lh5.googleusercontent.com/-Joi3bRfd4yo/Tlml3l9ZlpI/AAAAAAAAAVk/mi1awJkUObc/8038.gif";
image["8039"] = "https://lh5.googleusercontent.com/-PWLJwWlP3_c/Tlml3n9dtBI/AAAAAAAAAVo/ZajihK_5Yhk/8039.gif";
image["8040"] = "https://lh6.googleusercontent.com/-8V1qmtSGmi8/Tlml3xnR8oI/AAAAAAAAAV0/Vu9I_iBUVd4/8040.gif";
image["8041"] = "https://lh3.googleusercontent.com/-FVCnWaKBmrI/Tlml38FCNLI/AAAAAAAAAVs/MTlDPAnkds8/8041.gif";
image["8042"] = "https://lh3.googleusercontent.com/-qDVxX_haCcQ/Tlml3ynOb5I/AAAAAAAAAVw/zQ8A4ekUatc/8042.gif";
image["8043"] = "https://lh5.googleusercontent.com/-iMmfVT4AHmQ/Tlml38kotGI/AAAAAAAAAV4/Ax52iVj21qA/8043.gif";
image["a"] = ImageRoot + "TBJ2c61PRAI/AAAAAAAAADw/BKCfTUxcc2I/s128/a.png";
image["abg"] = ImageRoot + "TCDa8xIP3OI/AAAAAAAAAH4/MKfsCIh617A/abg.png";
image["add"] = ImageRoot + "TBJ2c7v6_ZI/AAAAAAAAAD0/XgKbK2ERwwk/s128/add.png";
image["broadcast"] = ImageRoot + "TBrcIbkdtRI/AAAAAAAAAHc/LSUKIc93Ss0/broadcast.png";
image["cancel"] = ImageRoot + "TBmgrcQEkJI/AAAAAAAAAHE/42M6PyEupmA/cancel.png";
image["copy"] = ImageRoot + "TBJ2v4x7kBI/AAAAAAAAAD4/nGTq0lV6W3g/s128/copy.png";
image["delete"] = ImageRoot + "TBJ2vxEQZSI/AAAAAAAAAD8/2VER3JnbQ5o/s128/delete.png";
image["down"] = ImageRoot + "TBJ2wAra0nI/AAAAAAAAAEA/waxGYe_7Haw/s128/down.png";
image["flag_blue"] = ImageRoot + "TBJ2wY-YKgI/AAAAAAAAAEE/ikROEnP9H-Q/s128/flag_blue.png";
image["friend"] = ImageRoot + "TBJ4B8iRX9I/AAAAAAAAAFo/BYCURw7UfA0/s128/friend.png";
image["friends"] = ImageRoot + "TBg8DhRkuNI/AAAAAAAAAGs/oOmRkkExnIw/friends.png";
image["garet"] = ImageRoot + "TBJ2wb6JumI/AAAAAAAAAEI/gu6_hiBrnWY/s128/garet.png";
image["i"] = ImageRoot + "TBJ2_MoUXDI/AAAAAAAAAEM/DhgT-nQYB3I/s128/i.png";
image["info"] = ImageRoot + "TBJ2_JBWr3I/AAAAAAAAAEQ/8SA9w6RWnIk/s128/info.png";
image["key"] = ImageRoot + "TBJ2_ZUhGZI/AAAAAAAAAEU/etphxTzqlro/s128/key.png";
image["loading"] = ImageRoot + "TBJ2_qB7kYI/AAAAAAAAAEY/b5yvheqkEb4/s128/loading.gif";
image["message"] = ImageRoot + "TBJ2_v67piI/AAAAAAAAAEc/2LMqJRP2Ieo/s128/message.png";
image["mobdata"] = ImageRoot + "TBJ3JT3sGtI/AAAAAAAAAEg/A-X9_Owjc3s/s128/mobdata.png";
image["moon"] = ImageRoot + "TBJ3JbAzMUI/AAAAAAAAAEk/KC650R05wbg/s128/moon.png";
image["next"] = ImageRoot + "TBJ3JshvnnI/AAAAAAAAAEo/6-KcLbANiRE/s128/next.png";
image["no"] = ImageRoot + "TBrcIA2qdlI/AAAAAAAAAHY/Nl_m_E8FLRA/no.png";
image["pet"] = ImageRoot + "TBJ3JpKKzlI/AAAAAAAAAEs/fqRrRWYLhjc/s128/pet.png";
image["prev"] = ImageRoot + "TBJ3J2QGFJI/AAAAAAAAAEw/uhY6NK1Ov2c/s128/prev.png";
image["refresh"] = ImageRoot + "TBJ3U3_IJ0I/AAAAAAAAAE0/7sSkZJR2xEE/s128/refresh.png";
image["reload"] = ImageRoot + "TBJ3VIOCrqI/AAAAAAAAAE4/Lv4k-AulUbU/s128/reload.png";
image["save"] = ImageRoot + "TBJ3Ve6M4YI/AAAAAAAAAE8/uT4y7hNQrj8/s128/save.png";
image["scell"] = ImageRoot + "TBJ3VYToPnI/AAAAAAAAAFA/MbKzmyCxygc/s128/scell.png";
image["search"] = ImageRoot + "TBJ3VoA3PLI/AAAAAAAAAFE/EZI5rH341tE/s128/search.png";
image["setting"] = ImageRoot + "TBJ3cnpeKmI/AAAAAAAAAFI/uZMAh706SPg/s128/setting.png";
image["smile"] = ImageRoot + "TBmgrPtor-I/AAAAAAAAAHA/la2dvLbZLr0/smile.png";
image["speaker_on"] = ImageRoot + "TS6G_l5doDI/AAAAAAAAAJI/oBJv62NQgZQ/speaker_on.png";
image["speaker_off"] = ImageRoot + "TS6a82t56wI/AAAAAAAAAJY/F09c5KHfNEA/speaker_off.png";
image["star"] = ImageRoot + "TBJ3c_I6xYI/AAAAAAAAAFM/cZivVcZ6cFc/s128/star.png";
image["up"] = ImageRoot + "TBJ3c3RKueI/AAAAAAAAAFQ/noI2i3Kvvug/s128/up.png";
image["warning"] = ImageRoot + "TBJ3c9f8xSI/AAAAAAAAAFU/q15EyrwzpIg/s128/warning.png";
image["yes"] = ImageRoot + "TBJ3dBNJGcI/AAAAAAAAAFY/zqJ7_tA_gXw/s128/yes.png";
image["zargon"] = ImageRoot + "TBJ3e6v9vwI/AAAAAAAAAFc/8LcSQbLltOc/s128/zargon.png";
image["niku"] = "https://lh3.googleusercontent.com/-Bi36T2C3tIk/TmBWDlHgnqI/AAAAAAAAAW8/OWY5pykM9pk/niku.png";
image["ringop"] = "https://lh3.googleusercontent.com/-WdTJui_dNXM/TmBWDlnYDpI/AAAAAAAAAW4/YpAr4GmeITE/ringop.png";
image["snow"] = "https://lh5.googleusercontent.com/-qVtoXA8qwHo/TmBWDmN6QUI/AAAAAAAAAW0/MCLDHguCjiw/snow.png";
image["lg"] = "https://lh6.googleusercontent.com/-sj6gFOoNLyk/TmBWD74-TFI/AAAAAAAAAXE/2YCjNnW_-bA/lg.png";
image["salad"] = "https://lh3.googleusercontent.com/-o-1F0gkNUag/TmBWD3hTs7I/AAAAAAAAAXA/uNOsgHisys8/salad.png";
var window_width = 820;
resizeTo(window_width, 175);
var window_size = [];
window_size["message"] = [window_width, 175];
window_size["setting"] = [window_width, 800];
window_size["mobdata"] = [window_width, 800];
window_size["friend"] = [window_width, 800];
window_size["info"] = [window_width, 225];

function menuTab(tab) {
	$('message').style.display = "none";
	$('setting').style.display = "none";
	$('mobdata').style.display = "none";
	$('friend').style.display = "none";
	$('info').style.display = "none";
	$(tab).style.display = "block";
	var h = $(tab).offsetHeight;
	var m = $('menu');
	m.style.height = h + "px";
	resizeTo(window_size[tab][0], window_size[tab][1]);
	var icons = m.getElementsByTagName('img');
	for (i = 0; i < icons.length; i++) {
		icons[i].className = "";
	}
	$(tab + '-icon').className = "on";
}

function Reload() {
	if (LoadFlag == 1) {
		if (confirm('再起動しますか？') == true) {
			window.location.reload();
		}
	}
}

function setMenuTab(tab, d) {
	if (LoadFlag == 0 || HomNum <= 0) {
		return
	}
	var stab = $('set_main');
	var tags = stab.getElementsByTagName('div');
	var tabs = $('set_menu').getElementsByTagName('li');
	for (i = 0; i < tags.length; i++) {
		tags[i].style.display = "none";
		tabs[i].style.borderBottom = "solid 2px #9c9cb0";
		tabs[i].className = "";
	}
	$(tab).style.display = "block";
	tabs[d].style.borderBottom = "solid 2px #FFF";
	tabs[d].className = "activetab";
}
var qTipTag = "a,label,input";
var qTipX = 15;
var qTipY = -20;
tooltip = {
	name: "qTip",
	offsetX: qTipX,
	offsetY: qTipY,
	tip: null
}
tooltip.init = (function() {
	var tipNameSpaceURI = "http://www.w3.org/1999/xhtml";
	if (!tipContainerID) {
		var tipContainerID = "qTip";
	}
	var tipContainer = document.getElementById(tipContainerID);
	if (!tipContainer) {
		tipContainer = document.createElementNS ? document.createElementNS(tipNameSpaceURI, "div") : document.createElement("div");
		tipContainer.setAttribute("id", tipContainerID);
		document.getElementsByTagName("body").item(0).appendChild(tipContainer);
	}
	if (!document.getElementById) return;
	this.tip = document.getElementById(this.name);
	if (this.tip) document.onmousemove = (function(evt) {
		tooltip.move(evt)
	});
	var a, sTitle, elements;
	var elementList = qTipTag.split(",");
	for (var j = 0; j < elementList.length; j++) {
		elements = document.getElementsByTagName(elementList[j]);
		if (elements) {
			for (var i = 0; i < elements.length; i++) {
				a = elements[i];
				sTitle = a.getAttribute("title");
				if (sTitle) {
					a.setAttribute("tiptitle", sTitle);
					a.removeAttribute("title");
					a.removeAttribute("alt");
					a.onmouseover = (function() {
						tooltip.show(this.getAttribute('tiptitle'))
					});
					a.onmouseout = (function() {
						tooltip.hide()
					});
				}
			}
		}
	}
});
tooltip.move = (function(evt) {
	var x = 0,
		y = 0;
	if (document.all) {
		x = (document.documentElement && document.documentElement.scrollLeft) ? document.documentElement.scrollLeft : document.body.scrollLeft;
		y = (document.documentElement && document.documentElement.scrollTop) ? document.documentElement.scrollTop : document.body.scrollTop;
		x += window.event.clientX;
		y += window.event.clientY;
	} else {
		x = evt.pageX;
		y = evt.pageY;
	}
	this.tip.style.left = (x + this.offsetX) + "px";
	this.tip.style.top = (y + this.offsetY) + "px";
});
tooltip.show = (function(text) {
	if (!this.tip) return;
	this.tip.innerHTML = text;
	this.tip.style.display = "block";
});
tooltip.hide = (function() {
	if (!this.tip) return;
	this.tip.innerHTML = "";
	this.tip.style.display = "none";
});
var MobList = [];
var MobData = [];
var PlayerList = [];
var lastmob = 0;
var LocationList = [];
var FieldList = [];
var PickedList = [];
var infomsg = ["インフォメーション", "", ""];

function createhttprequest() {
	var request = null;
	if ("XMLHttpRequest" in window) {
		request = new XMLHttpRequest();
	} else if ("ActiveXObject" in window) {
		try {
			request = new ActiveXobject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}
	return request;
}
var request = [];

function requestsorce(url, list) {
	request[list] = createhttprequest();
	request[list].open("GET", url, true);
	request[list].onreadystatechange = sorceget;
	request[list].send(null);
}

function sorceget() {
	if (request.readyState == 4 && request.status == 200) {
		return true;
	} else {
		return false;
	}
}
CSV_Files = [];
CSV_Files[0] = ["https://docs.google.com/spreadsheet/pub?key=0Ak6MQYrwgOpscF9tSmZTU2pqOVdSaXVObC01TWVBT1E&single=true&gid=5&output=csv", "Player"];
CSV_Files[1] = ["https://docs.google.com/spreadsheet/pub?key=0Ak6MQYrwgOpscF9tSmZTU2pqOVdSaXVObC01TWVBT1E&single=true&gid=3&output=csv", "Picked"];
CSV_Files[2] = ["https://docs.google.com/spreadsheet/pub?key=0Ak6MQYrwgOpscF9tSmZTU2pqOVdSaXVObC01TWVBT1E&single=true&gid=2&output=csv", "Field"];
CSV_Files[3] = ["https://docs.google.com/spreadsheet/pub?key=0Ak6MQYrwgOpscF9tSmZTU2pqOVdSaXVObC01TWVBT1E&single=true&gid=1&output=csv", "Location"];
CSV_Files[4] = ["https://docs.google.com/spreadsheet/pub?key=0Ak6MQYrwgOpscF9tSmZTU2pqOVdSaXVObC01TWVBT1E&single=true&gid=0&output=csv", "mob"];
CSV_Files[5] = ["https://docs.google.com/spreadsheet/pub?key=0Ak6MQYrwgOpscF9tSmZTU2pqOVdSaXVObC01TWVBT1E&single=true&gid=6&output=csv", "mobdata"];
CSV_Files[6] = ["https://docs.google.com/spreadsheet/pub?key=0Ak6MQYrwgOpscF9tSmZTU2pqOVdSaXVObC01TWVBT1E&single=true&gid=4&output=csv", "Info"];
LoadedCount = 0;

function GetCSV(list) {
	var count = 0;
	for (i = 0; i < list.length; i++) {
		var url = list[i][0];
		var name = list[i][1];
		if (request[name].readyState == 4 && request[name].status == 200) {
			count++;
		}
	}
	if (count < list.length) {
		setTimeout("GetCSV(CSV_Files)", 150);
		return
	}
	for (j = 0; j < list.length; j++) {
		var url = list[j][0];
		var name = list[j][1];
		var file = request[name].responseText;
		var n = file.split("\n");
		var ef = n[n.length - 1].replace(/,/g, "");
		if (ef != "end") {
			requestsorce(url, name);
			setTimeout("GetCSV(CSV_Files)", 150);
			return
		}
		LoadCSV(n, name);
		LoadedCount++;
	}
	CheckCSV();
}

function LoadDate() {
	var ldpass = RO_Dir + "cocco_data.csv";
	var stream = new ActiveXObject("ADODB.Stream");
	var dataIndex = "";
	var str = "";
	var i = 0;
	try {
		stream.type = 2;
		stream.charset = "utf-8";
		stream.open();
		stream.loadFromFile(ldpass);
		var altext = stream.readText(-1);
		var aldata = altext.split("\n");
		for (j = 0; j < aldata.length - 1; j++) {
			str = aldata[j];
			if (str.match(/^--/)) {
				dataIndex = str.replace(/--/, "");
				i = 0;
			} else if (str.match(/^end/)) {} else {
				LoadLocalCSV(str, dataIndex, i);
				i++;
			}
		}
	} catch (e) {
		setTimeout("requestsorce(CSV_Files[0][0],CSV_Files[0][1])", 20);
		setTimeout("requestsorce(CSV_Files[1][0],CSV_Files[1][1])", 150);
		setTimeout("requestsorce(CSV_Files[2][0],CSV_Files[2][1])", 300);
		setTimeout("requestsorce(CSV_Files[3][0],CSV_Files[3][1])", 500);
		setTimeout("requestsorce(CSV_Files[4][0],CSV_Files[4][1])", 900);
		setTimeout("requestsorce(CSV_Files[5][0],CSV_Files[5][1])", 1800);
		setTimeout("requestsorce(CSV_Files[6][0],CSV_Files[6][1])", 1);
		setTimeout("GetCSV(CSV_Files);", 2500);
	}
	stream.close();
	setTimeout("requestsorce(CSV_Files[6][0],CSV_Files[6][1])", 1);
	setTimeout("CheckLocalCSV();", 1500);
}

function LoadLocalCSV(n, name, i) {
	if (name == "mob") {
		MobList[i] = n;
	} else if (name == "Player") {
		PlayerList[i] = n;
	} else if (name == "mobdata") {
		MobData[i] = n;
	} else if (name == "Location") {
		LocationList[i + 1] = n;
	} else if (name == "Field") {
		FieldList[i + 1] = n;
	} else if (name == "Picked") {
		PickedList[i + 1] = n;
	} else if (name == "Info") {
		LocalData = n;
	}
	lastmob = MobList.length;
}

function LoadCSV(n, name) {
	for (i = 0; i < (n.length); i++) {
		if (name == "mob") {
			MobList[i] = n[i + 1];
		} else if (name == "Player") {
			PlayerList[i] = n[i];
		} else if (name == "mobdata") {
			MobData[i] = n[i];
		} else if (name == "Location") {
			LocationList[i] = n[i - 1];
		} else if (name == "Field") {
			FieldList[i] = n[i - 1];
		} else if (name == "Picked") {
			PickedList[i] = n[i - 1];
		} else if (name == "Info") {
			infomsg[i] = n[i];
		}
	}
	lastmob = MobList.length;
}

function CheckLocalCSV() {
	if (request[CSV_Files[6][1]].readyState == 4 && request[CSV_Files[6][1]].status == 200) {
		var file = request[CSV_Files[6][1]].responseText;
		infomsg = file.split("\n");
	}
	CheckCSV();
}

function CheckCSV() {
	if (MobList[1] && PlayerList[1] && MobData[1]) {
		var at = PlayerList[1].split(",");
		var bt = MobData[1].split(",");
		if (at[1]) {
			if (MobList[1].indexOf("ポリン", 0) >= 0 && at[1].indexOf("Swordman", 0) >= 0 && bt[0].indexOf("1001", 0) >= 0) {
				LoadFlag = 1;
				PlayerConfig();
				PutInfo();
				LoadSet();
				MakeForm();
				LoadFriend();
				tooltip.init();
				GetCSV = (function() {});
				CheckIDPASS();
				return
			}
		}
		LoadingError();
	}
}

function LoadingError() {
	$('message-display').innerHTML = '<span style="color:#F00;">データのロードに失敗しました。<a style="cursor:pointer;" onclick="window.location.reload()">リロード</a>してください。</span><br /><br />何度かリロードしても失敗する場合、一旦終了して<br /><a href="http://cocco.privatemoon.jp/tool/localdata/" target="_blank"">ローカル用データ</a>をダウンロードしてください。';
}

function PlayerConfig() {
	var sam = [];
	for (i = 0; i < PlayerList.length - 1; i++) {
		var m = PlayerList[i].split(",");
		sam[m[0]] = m[1];
	}
	PlayerList = sam;
}

function PutInfo() {
	$('infomsg').innerHTML = infomsg[0];
	var aiVerInfo = "AI Ver.";
	var toolVerInfo = "総合ツール Ver." + "<span>" + thisVer + "</span>";
	var aipass = RO_Dir + "AI.lua";
	objFSO = new ActiveXObject("Scripting.FileSystemObject");
	if (!objFSO.FileExists(aipass)) {
		alert("ディレクトリにAI.luaがありません。");
		return
	}
	objFile = objFSO.OpenTextFile(aipass, ForReading, false);
	var head = objFile.ReadLine();
	cc = new RegExp("こっこAI");
	if (!head.match(cc)) {
		alert("読み込み先のAIがこっこAIではない可能性があります。");
		return
	}
	head = head.split("Ver");
	head[1] = head[1].replace(/^\s+/, "");
	var nver = head[1].split(" ");
	aiVerInfo = aiVerInfo + "<span>" + nver[0] + "</span>";
	var latestver = infomsg[1];
	if (!latestver.match(nver[0])) {
		if (Number(latestver.replace(/[^0-9|.]/g, "")) > Number(nver[0].replace(/[^0-9|.]/g, ""))) {
			aiVerInfo = aiVerInfo + "  <a href=\"http://cocco.privatemoon.jp/download/\" target=\"_blank\" style=\"background:#FE0\">最新Verがあります (" + latestver + ")</a>";
			$('menu').getElementsByTagName('li')[4].style.backgroundColor = "#FE0";
		}
	}
	if (!thisVer.match(infomsg[2])) {
		if (Number(infomsg[2].replace(/[^0-9|.]/g, "")) > Number(thisVer.replace(/[^0-9|.]/g, ""))) {
			toolVerInfo = toolVerInfo + "  <a href=\"http://cocco.privatemoon.jp/download/\" target=\"_blank\" style=\"background:#FE0\">最新Verがあります (" + infomsg[2] + ")</a>";
			$('menu').getElementsByTagName('li')[4].style.backgroundColor = "#FE0";
		}
	}
	$('ver-info').innerHTML = aiVerInfo;
	$('t-ver-info').innerHTML = toolVerInfo;
	if (LocalData && infomsg[4]) {
		var addld = "";
		if (!LocalData.match(infomsg[4])) {
			addld = "  <a href=\"#\" onclick=\"UpdateLocalData();\" style=\"background:#FE0\">最新Verに更新 (" + infomsg[4] + ")</a>";
			$('menu').getElementsByTagName('li')[4].style.backgroundColor = "#FE0";
		}
		$('localdata-info').innerHTML = "DB: Local Ver.<span>" + LocalData + "</span>" + addld;
	} else {
		$('localdata-info').innerHTML = "DB: Online";
	}
	objFile.Close();
}

function UpdateLocalData() {
	if (!confirm("ローカルデータベースを更新します。よろしいですか？\n\n※cocco_data.csvを他のプログラムで開いている場合は、終了してください。\n※更新完了後は、本ツールを再起動してください。")) {
		return
	}
	var updatingImg = '<img src="http://lh6.ggpht.com/_8Hzx_QBHnQA/TBJ2_qB7kYI/AAAAAAAAAEY/b5yvheqkEb4/s128/loading.gif" width="16" height="16" />';
	$('localdata-info').innerHTML = "DB: Local Ver.<span>" + LocalData + "</span><span class=\"updating\">" + updatingImg + "<span>更新中</span></a>";
	requestsorce("http://cocco.privatemoon.jp/ai/localdata-gen/", "LocalData");
	request["LocalData"].onreadystatechange = SaveLocalData;
}

function SaveLocalData() {
	if (request["LocalData"].readyState == 4 && request["LocalData"].status == 200) {
		var ldpass = RO_Dir + "cocco_data.csv";
		var stream = new ActiveXObject("ADODB.Stream");
		var local_data = request["LocalData"].responseText;
		if (!local_data) {
			coccoAlert("データベースファイルがダウンロード出来ませんでした。<br />しばらくしてから再度更新してください。");
			$('localdata-info').innerHTML = "DB: Local Ver.<span>" + LocalData + "</span>" + "  <a href=\"#\" onclick=\"UpdateLocalData();\" style=\"background:#FE0\">最新Verに更新 (" + infomsg[4] + ")</a>";
			$('menu').getElementsByTagName('li')[4].style.backgroundColor = "#FE0";
			return
		}
		try {
			stream.type = 2;
			stream.charset = "utf-8";
			stream.open();
			stream.writeText(local_data);
			try {
				stream.saveToFile(ldpass, 2);
			} catch (e) {
				alert(ldpass + "は他のプログラムによって使用されいるためセーブできません。\nセーブするには他のプログラムを終了してください。");
				stream.close();
				return
			}
			stream.close();
		} catch (e) {
			coccoAlert("ローカルファイル更新エラー");
			return
		}
		LocalData = infomsg[4];
		$('localdata-info').innerHTML = "DB: Local Ver." + LocalData;
		if (confirm("更新完了しました。ツールを再起動します。")) {
			window.location.reload();
		}
	} else {
		return false
	}
}

function coccoAlert(str) {
	$('alert-base').style.display = "block";
	$('alert').innerHTML = str;
}
var ComSet = [];
var DefComSet = [];
var HomSet = [];
var HomNum = 0;
var DefaultName = "noname";
var SkillNum = 0;
var ASTnum = 0;
var HomSkillTable = [];
unSaved = false;

function JobsSelect() {
	document.write('<option value="">--職業</option><option value="0">ノービス</option><option value="1">ソードマン</option><option value="2">マジシャン</option><option value="3">アーチャー</option><option value="4">アコライト</option><option value="5">マーチャント</option>');
	document.write('<option value="6">シーフ</option><option value="7">ナイト</option><option value="8">プリースト</option><option value="9">ウィザード</option><option value="10">ブラックスミス</option><option value="11">ハンター</option>');
	document.write('<option value="12">アサシン</option><option value="14">クルセイダー</option><option value="15">モンク</option><option value="16">セージ</option><option value="17">ローグ</option><option value="18">アルケミスト</option>');
	document.write('<option value="19">バード</option><option value="20">ダンサー</option><option value="23">スーパーノービス</option><option value="24">ガンスリンガー</option>');
	document.write('<option value="25">ニンジャ</option><option value="4008">ロードナイト</option><option value="4009">ハイプリースト</option><option value="4010">ハイウィザード</option><option value="4011">ホワイトスミス</option>');
	document.write('<option value="4012">スナイパー</option><option value="4013">アサシンクロス</option><option value="4015">パラディン</option><option value="4016">チャンピオン</option><option value="4017">プロフェッサー</option>');
	document.write('<option value="4018">チェイサー</option><option value="4019">クリエイター</option><option value="4020">クラウン</option><option value="4021">ジプシー</option><option value="4046">テコンキッド</option>');
	document.write('<option value="4047">拳聖</option><option value="4049">ソウルリンカー</option>');
	document.write('<option value="4054">ルーンナイト</option><option value="4055">ウォーロック</option><option value="4056">レンジャー</option>');
	document.write('<option value="4057">アークビショップ</option><option value="4058">メカニック</option><option value="4059">ギロチンクロス</option>');
	document.write('<option value="4066">ロイヤルガード</option><option value="4067">ソーサラー</option><option value="4068">ミンストレル</option><option value="4069">ワンダラー</option>');
	document.write('<option value="4070">修羅</option><option value="4071">ジェネティック</option><option value="4072">シャドーチェイサー</option>');
}

function SearchSelect() {
	document.write('<option value="0" selected>なし');
	document.write('<option value="18">アルケミスト</option><option value="4019">クリエイター</option><option value="4071">ジェネティック</option><option value="111">フキダシ</option>');
	document.write('<option value="1078">赤い草</option><option value="1079">青い草</option><option value="1080">緑色草</option>');
	document.write('<option value="1081">黄色草</option><option value="1082">白い草</option><option value="1083">輝く草</option>');
	document.write('<option value="1084">黒いキノコ</option><option value="1085">赤いキノコ</option><option value="6003">フィーリル（原）</option>');
	document.write('<option value="6004">バニルミルト（原）</option><option value="6001">リーフ（原）</option><option value="6002">アミストル（原）</option>');
	document.write('<option value="6007">フィーリル（亜）</option><option value="6008">バニルミルト（亜）</option><option value="6005">リーフ（亜）</option>');
	document.write('<option value="6006">アミストル（亜）</option>');
}
var homTypes = [];
homTypes[1] = "リーフ";
homTypes[2] = "アミストル";
homTypes[3] = "フィーリル";
homTypes[4] = "バニルミルト";
homTypes[5] = "リーフ亜種";
homTypes[6] = "アミストル亜種";
homTypes[7] = "フィーリル亜種";
homTypes[8] = "バニルミルト亜種";
homTypes[9] = "進化リーフ";
homTypes[10] = "進化アミストル";
homTypes[11] = "進化フィーリル";
homTypes[12] = "進化バニルミルト";
homTypes[13] = "進化リーフ亜種";
homTypes[14] = "進化アミストル亜種";
homTypes[15] = "進化フィーリル亜種";
homTypes[16] = "進化バニルミルト亜種";
homTypes[48] = "エイラ";
homTypes[49] = "バイエリ";
homTypes[50] = "セラ";
homTypes[51] = "ディーター";
homTypes[52] = "エレノア";
var SkillName = [];
SkillName[8001] = {
	j: "治癒の手",
	e: "HealingHands",
	t: "res",
	r: 15
};
SkillName[8002] = {
	j: "緊急回避",
	e: "UrgentEscape",
	t: "acc",
	r: 1
};
SkillName[8003] = {
	j: "脳手術",
	e: "BrainSurgery",
	t: "pus",
	r: 0
};
SkillName[8004] = {
	j: "メンタルチェンジ",
	e: "MentalChange",
	t: "buf",
	r: 1
};
SkillName[8005] = {
	j: "キャッスリング",
	e: "Castling",
	t: "tec",
	r: 15
};
SkillName[8006] = {
	j: "ディフェンス",
	e: "Defense",
	t: "buf",
	r: 1
};
SkillName[8007] = {
	j: "アダマンティウムスキン",
	e: "AdamantiumSkin",
	t: "pus",
	r: 0
};
SkillName[8008] = {
	j: "ブラッドラスト",
	e: "BloodLust",
	t: "buf",
	r: 1
};
SkillName[8009] = {
	j: "ムーンライト",
	e: "MoonLight",
	t: "atk",
	r: 15
};
SkillName[8010] = {
	j: "フリットムーブ",
	e: "FleetMove",
	t: "buf",
	r: 1
};
SkillName[8011] = {
	j: "オーバードスピード",
	e: "OveredSpeed",
	t: "buf",
	r: 1
};
SkillName[8012] = {
	j: "S.B.R.44",
	e: "SBR44",
	t: "sec",
	r: 15
};
SkillName[8013] = {
	j: "カプリス",
	e: "Caprice",
	t: "atk",
	r: 15
};
SkillName[8014] = {
	j: "カオティックベネディクション",
	e: "ChaoticVenediction",
	t: "res",
	r: 15
};
SkillName[8015] = {
	j: "チェンジインストラクション",
	e: "ChangeInstruction",
	t: "pus",
	r: 0
};
SkillName[8016] = {
	j: "バイオエクスプロージョン",
	e: "BioExplosion",
	t: "sec",
	r: 1
};
SkillName[8017] = {
	j: "未定義",
	e: "noskill",
	t: "n",
	r: 0
};
SkillName[8018] = {
	j: "サモンレギオン",
	e: "SummonLegion",
	t: "atk",
	r: 15
};
SkillName[8019] = {
	j: "ニードルオブパラライズ",
	e: "NeedleOfParalyze",
	t: "atk",
	r: 5
};
SkillName[8020] = {
	j: "ポイズンミスト",
	e: "PoisonMist",
	t: "atk",
	r: 15
};
SkillName[8021] = {
	j: "ペインキラー",
	e: "PainKiller",
	t: "buf",
	r: 9
};
SkillName[8022] = {
	j: "再生の光",
	e: "LightOfRegene",
	t: "buf",
	r: 1
};
SkillName[8023] = {
	j: "オーバードブースト",
	e: "OveredBoost",
	t: "buf",
	r: 1
};
SkillName[8024] = {
	j: "イレイサーカッター",
	e: "EraserCutter",
	t: "atk",
	r: 15
};
SkillName[8025] = {
	j: "ゼノスラッシャー",
	e: "XenoSlasher",
	t: "atk",
	r: 15
};
SkillName[8026] = {
	j: "サイレントブリーズ",
	e: "SilentBreeze",
	t: "atk",
	r: 15
};
SkillName[8027] = {
	j: "スタイルチェンジ",
	e: "StyleChange",
	t: "buf",
	r: 1
};
SkillName[8028] = {
	j: "ソニッククロウ",
	e: "SonicClaw",
	t: "atk",
	r: 1
};
SkillName[8029] = {
	j: "シルバーベインラッシュ",
	e: "SilverveinRush",
	t: "atk",
	r: 1
};
SkillName[8030] = {
	j: "ミッドナイトフレンジ",
	e: "MidnightFrenzy",
	t: "atk",
	r: 1
};
SkillName[8031] = {
	j: "シュタールホーン",
	e: "StahlHorn",
	t: "atk",
	r: 5
};
SkillName[8032] = {
	j: "ゴールデンペルジェ",
	e: "GoldeneFerse",
	t: "buf",
	r: 1
};
SkillName[8033] = {
	j: "シュタインワンド",
	e: "SteinWand",
	t: "buf",
	r: 1
};
SkillName[8034] = {
	j: "ハイリエージュスタンジェ",
	e: "HeiligeStange",
	t: "atk",
	r: 15
};
SkillName[8035] = {
	j: "アングリフスモドス",
	e: "AngriffsModus",
	t: "buf",
	r: 1
};
SkillName[8036] = {
	j: "ティンダーブレイカー",
	e: "TinderBreaker",
	t: "atk",
	r: 3
};
SkillName[8037] = {
	j: "C.B.C",
	e: "ContinualBreakCombo",
	t: "atk",
	r: 1
};
SkillName[8038] = {
	j: "E.Q.C",
	e: "EternalQuickCombo",
	t: "atk",
	r: 1
};
SkillName[8039] = {
	j: "マグマフロー",
	e: "MagmaFlow",
	t: "buf",
	r: 1
};
SkillName[8040] = {
	j: "グラニティックアーマー",
	e: "GraniticArmor",
	t: "buf",
	r: 1
};
SkillName[8041] = {
	j: "ラーヴァスライド",
	e: "LavaSlide",
	t: "atk",
	r: 1
};
SkillName[8042] = {
	j: "パイロクラスティック",
	e: "Pyroclastic",
	t: "buf",
	r: 1
};
SkillName[8043] = {
	j: "ボルカニックアッシュ",
	e: "VolcanicAsh",
	t: "atk",
	r: 15
};
var SkillText = [];
SkillText[8001] = "主人のHPを回復させる。<br />回復量はアコライトのヒールと同等。<br />使用時にレッドスリムポーションを1個消費。<br /><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>13</td><td>16</td><td>19</td><td>22</td><td>25</td></tr></table>";
SkillText[8002] = "プレイヤーとホムンクルスの移動速度を瞬間的に増加させる。<br /><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>20</td><td>25</td><td>30</td><td>35</td><td>40</td></tr><tr><th>速度増加</th><td>10%</td><td>20%</td><td>30%</td><td>40%</td><td>50%</td></tr><tr><th>持続時間</th><td>40秒</td><td>35秒</td><td>30秒</td><td>25秒</td><td>20秒</td></tr><tr><th>クールタイム</th><td>35秒</td><td>35秒</td><td>35秒</td><td>35秒</td><td>35秒</td></tr></table>";
SkillText[8003] = "";
SkillText[8004] = "最大5分間ホムンクルスのVITとINTを増加<br />使用直後HPSPは全快する。（その後SP100消費。ただしSP100ないと使えない）<br />そしてMATK数値で通常攻撃を加える。<br />最大5分後には状態が解けてHP/SP数値が10になる。<br /><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th></tr><tr><th>消費SP</th><td>100</td><td>100</td><td>100</td></tr><tr><th>持続時間</th><td>60秒</td><td>180秒</td><td>300秒</td></tr><tr><th>VIT増加量</th><td>30</td><td>60</td><td>90</td></tr><tr><th>INT増加量</th><td>20</td><td>40</td><td>60</td></tr></table>";
SkillText[8005] = "";
SkillText[8006] = "プレイヤーとホムンクルスの防御力を瞬間的に増加させる。<br /><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>20</td><td>25</td><td>30</td><td>35</td><td>40</td></tr><tr><th>DEF増加量</th><td>2</td><td>4</td><td>6</td><td>8</td><td>10</td></tr><tr><th>持続時間</th><td>40秒</td><td>35秒</td><td>30秒</td><td>25秒</td><td>20秒</td></tr></table>";
SkillText[8007] = "";
SkillText[8008] = "最大5分間ホムンクルスの攻撃力が最大1.5倍。<br />一定確率で敵に与えるダメージの20%にあたる量のHPをホムンクルスが回復する。<table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th></tr><tr><th>消費SP</th><td>120</td><td>120</td><td>120</td></tr><tr><th>持続時間</th><td>60秒</td><td>180秒</td><td>300秒</td></tr><tr><th>攻撃力</th><td>130%</td><td>140%</td><td>150%</td></tr><tr><th>回復確率</th><td>3%</td><td>6%</td><td>9%</td></tr></table>";
SkillText[8009] = "対象指定ターゲットにクチバシで連打攻撃をする。<br />念属性にも有効。スキルディレイは2秒強。<table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>4</td><td>8</td><td>12</td><td>16</td><td>20</td></tr><tr><th>攻撃力</th><td>220%</td><td>330%</td><td>440%</td><td>550%</td><td>660%</td></tr></table>";
SkillText[8010] = "自身の攻撃速度と攻撃力を一時的に増加させる。<br /><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>30</td><td>40</td><td>50</td><td>60</td><td>70</td></tr><tr><th>攻撃速度増加</th><td>3</td><td>6</td><td>9</td><td>12</td><td>15</td></tr><tr><th>攻撃力</th><td>110%</td><td>115%</td><td>120%</td><td>125%</td><td>130%</td></tr><tr><th>持続時間</th><td>60秒</td><td>55秒</td><td>50秒</td><td>45秒</td><td>40秒</td></tr><tr><th>クールタイム</th><td>30秒</td><td>27.5秒</td><td>25秒</td><td>22.5秒</td><td>20秒</td></tr></table>";
SkillText[8011] = "自身の回避率一時的に増加させる。<br />※現在ステータス値は変化するが効果は未実装<br /><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>30</td><td>40</td><td>50</td><td>60</td><td>70</td></tr><tr><th>回避率増加</th><td>20</td><td>30</td><td>40</td><td>50</td><td>60</td></tr><tr><th>持続時間</th><td>60秒</td><td>55秒</td><td>50秒</td><td>45秒</td><td>40秒</td></tr><tr><th>クールタイム</th><td>30秒</td><td>27.5秒</td><td>25秒</td><td>22.5秒</td><td>20秒</td></tr></table>";
SkillText[8012] = "";
SkillText[8013] = "ランダムでボルト類スキルの中の1つが発動される。<br />発動するボルトのLvは、カプリスのLvで決まる。<br />ダメージや使用ディレイはマジシャン系スキルと同等。<table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>22</td><td>24</td><td>26</td><td>28</td><td>30</td></tr><tr><th>発動ボルトLv</th><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td></tr></table>";
SkillText[8014] = "自身、主人、画面内の敵のいずれか1個体に次の確率によりヒールスキルを使用する。<br />回復量はアコライトのヒールと同等<br />聖属性はないため、不死属性相手でも回復する。<br />※現在、ホムンクルス自身のHPは回復しない不具合がある。<table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>40</td><td>40</td><td>40</td><td>40</td><td>40</td></tr><tr><th>使用ヒールLv</th><td>1</td><td>1～2</td><td>1～3</td><td>1～4</td><td>1～5</td></tr><tr><th>自分</th><td>20%</td><td>50%</td><td>25%</td><td>60%</td><td>34%</td></tr><tr><th>主人</th><td>30%</td><td>10%</td><td>50%</td><td>4%</td><td>33%</td></tr><tr><th>敵</th><td>50%</td><td>40%</td><td>25%</td><td>36%</td><td>33%</td></tr></table>";
SkillText[8015] = "";
SkillText[8016] = "";
SkillText[8017] = "";
SkillText[8018] = "虫の群れを召喚して、対象の1体を攻撃する。<br>スキルレベルが上がるほど、強力な虫の群れが召喚される。<br>射程距離9セル。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>60</td><td>80</td><td>100</td><td>120</td><td>140</td></tr><tr><th>召喚Mob</th><td>ﾎｰﾈｯﾄ×3</td><td>ｼﾞｬｲｱﾝﾄﾎｰﾈｯﾄ×3</td><td>ｼﾞｬｲｱﾝﾄﾎｰﾈｯﾄ×4</td><td>ﾙｼｵﾗｳﾞｪｽﾊﾟ×4</td><td>ﾙｼｵﾗｳﾞｪｽﾊﾟ×5</td></tr><tr><th>持続時間</th><td>20秒</td><td>30秒</td><td>40秒</td><td>50秒</td><td>60秒</td></tr></table>";
SkillText[8019] = "強力な麻痺毒を利用して毒属性のダメージと共に対象を状態異常：麻痺状態にする。<br>麻痺状態に陥った場合、移動することができず、キャスティング時間が増えて防御力が減少する。<br>麻痺の持続時間は、対象のVITとLUKによって減少される。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>48</td><td>60</td><td>72</td><td>84</td><td>96</td></tr><tr><th>クールタイム</th><td>0秒</td><td>4秒</td><td>8秒</td><td>12秒</td><td>16秒</td></tr><tr><th>物理攻撃力</th><td>800%</td><td>900%</td><td>1000%</td><td>1100%</td><td>1200%</td></tr><tr><th>麻痺確率</th><td>40%</td><td>55%</td><td>70%</td><td>85%</td><td>100%</td></tr></table>";
SkillText[8020] = "一定の範囲に毒の粉を分散させ、範囲内の対象に継続的に毒属性ダメージを与え、一定確率で暗闇をかける。<br>2つ以上設置することができない。<br>攻撃範囲：7×7。射程距離5セル。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>20</td><td>25</td><td>30</td><td>35</td><td>40</td></tr><tr><th>クールタイム</th><td>2秒</td><td>2秒</td><td>2秒</td><td>2秒</td><td>2秒</td></tr><tr><th>毒属性魔法攻撃力</th><td>40％</td><td>80％</td><td>120％</td><td>160％</td><td>200％</td></tr><tr><th>効果範囲</th><td>7×7</td><td>7×7</td><td>7×7</td><td>7×7</td><td>7×7</td></tr><tr><th>持続時間</th><td>12秒</td><td>14秒</td><td>16秒</td><td>18秒</td><td>20秒</td></tr><tr><th>暗黒確率</th><td>20%</td><td>40%</td><td>60%</td><td>80%</td><td>100%</td></tr></table>";
SkillText[8021] = "対象1体に弱い麻痺毒を注入して、ダメージを受けた時、HPの減少を遅らせる。<br>ただし副作用のため、攻撃速度が少し遅くなる。<br>ホムンクルス自身にかけることはできない。<br>射程距離1セル。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>48</td><td>52</td><td>56</td><td>60</td><td>64</td></tr><tr><th>クールタイム</th><td>0秒</td><td>4秒</td><td>8秒</td><td>12秒</td><td>16秒</td></tr><tr><th>ダメージ減少量</th><td>200</td><td>400</td><td>600</td><td>800</td><td>1000</td></tr><tr><th>持続時間</th><td>30秒</td><td>27.5秒</td><td>25秒</td><td>22.5秒</td><td>20秒</td></tr></table>";
SkillText[8022] = "ホムンクルスが主人に再生の光の効果をかける。<br>持続時間中に主人が死亡した場合、自分を犠牲にして、自動的に主人を復活させる。<br>親密度が「きわめて親しい」時にのみ使用可能で、スキル発動後、親密度が低くなる。<br>死から復活させる他の効果にかかっている場合は、その効果が優先される。<br>スキルレベルが上がるほど、復活時に回復するHP量が増加する。<br>ホムンクルスが死亡した状態でも、効果は維持される。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>40</td><td>50</td><td>60</td><td>70</td><td>80</td></tr><tr><th>復活時HP</th><td>--%</td><td>--%</td><td>--%</td><td>--%</td><td>--%</td></tr><tr><th>持続時間</th><td>360秒</td><td>420秒</td><td>480秒</td><td>540秒</td><td>600秒</td></tr></table>";
SkillText[8023] = "一時的にホムンクルスと、そのマスターの回避率と攻撃速度を固定するかわりに、防御力が1/2に減少。<br>ただし、持続時間中は、他の回避率と攻撃速度の変化に影響を与えるあらゆる効果にかからない。<br>また、持続時間が終わった後、ホムンクルスの満腹度が50減少し、マスターのSPが半減する。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>70</td><td>90</td><td>110</td><td>130</td><td>150</td></tr><tr><th>FLEE</th><td>340</td><td>380</td><td>420</td><td>460</td><td>500</td></tr><tr><th>ASPD</th><td>181</td><td>183</td><td>185</td><td>187</td><td>189</td></tr><tr><th>持続時間</th><td>10秒</td><td>30秒</td><td>50秒</td><td>70秒</td><td>90秒</td></tr></table>";
SkillText[8024] = "音速の刃を作成して、遠距離の敵1体を複数回殴打する。<br>スキルレベルに応じて、風属性ダメージとしても、無属性ダメージとしても使用可能。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>25</td><td>30</td><td>35</td><td>40</td><td>45</td></tr><tr><th>クールタイム</th><td>1.0秒</td><td>1.5秒</td><td>2.0秒</td><td>2.5秒</td><td>3.0秒</td></tr><tr><th>魔法攻撃力</th><td>600%</td><td>1000%</td><td>800%</td><td>1200%</td><td>1000%</td></tr><tr><th>属性</th><td>風</td><td>無</td><td>風</td><td>無</td><td>風</td></tr><tr><th>射程</th><td>7</td><td>7</td><td>7</td><td>7</td><td>7</td></tr></table>";
SkillText[8025] = "イレイサーカッターを範囲化する。<br>イレイサーカッターと同様に、スキルレベルに応じて、ダメージ属性が変化する。<br>ダメージを受けたすべてのターゲットは、低確率で状態異常：出血にかかる。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>90</td><td>100</td><td>110</td><td>120</td><td>130</td></tr><tr><th>クールタイム</th><td>1.0秒</td><td>1.5秒</td><td>2.0秒</td><td>2.5秒</td><td>3.0秒</td></tr><tr><th>魔法攻撃力</th><td>500%</td><td>700%</td><td>600%</td><td>900%</td><td>700%</td></tr><tr><th>射程</th><td>7</td><td>7</td><td>7</td><td>7</td><td>7</td></tr><tr><th>範囲</th><td>5×5</td><td>7×7</td><td>7×7</td><td>9×9</td><td>9×9</td></tr><tr><th>属性</th><td>風</td><td>無</td><td>風</td><td>無</td><td>風</td></tr><tr><th>出血確率</th><td>1%</td><td>2%</td><td>3%</td><td>4%</td><td>5%</td></tr></table>";
SkillText[8026] = "沈黙の風。対象1体のHPを一定の回復させるが、沈黙状態にしスキルを使用できないようにする。<br>代わりに、この沈黙の効果は、特定の状態異常を除去する効果がある。味方には成功率が2倍になる。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>80</td><td>80</td><td>80</td><td>80</td><td>80</td></tr><tr><th>持続時間</th><td>9秒</td><td>12秒</td><td>15秒</td><td>18秒</td><td>21秒</td></tr><tr><th>射程</th><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td></tr><tr><th>成功率</th><td>100%</td><td>100%</td><td>100%</td><td>100%</td><td>100%</td></tr></table>";
SkillText[8027] = "ホムンクルスのスタイルをファイターからグラップラー、あるいはグラップラーからファイターに変える。<br>ファイタースタイルのときに攻撃をしたり、ダメージを受けると一定の確率で気弾が蓄積される。<br><table class=s-table><tr><th>Lv</th><th>1</th></tr><tr><th>消費SP</th><td>35</td></tr></table>";
SkillText[8028] = "ファイタースタイルでのみ使用可能。対象1体を高速で指爪攻撃する。<br>現在蓄積されている気弾の数分ヒットする。気弾が存在しない場合はスキルが発動しない。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>20</td><td>25</td><td>30</td><td>35</td><td>40</td></tr><tr><th>物理攻撃力</th><td>40%</td><td>80%</td><td>120%</td><td>160%</td><td>200%</td></tr><tr><th>クールタイム</th><td>1秒</td><td>2秒</td><td>3秒</td><td>4秒</td><td>5秒</td></tr></table>";
SkillText[8029] = "ファイタースタイルでのみ使用可能。ソニッククロウ使用後の連携でのみ発動する。<br>スキル使用時、気弾を1つ消費する。<br>対象にダメージを与えると同時に一定の確率で状態異常：スタンをかける。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>10</td><td>15</td><td>20</td><td>25</td><td>30</td></tr><tr><th>物理攻撃力</th><td>150%</td><td>300%</td><td>450%</td><td>600%</td><td>750%</td></tr><tr><th>スタン確率</th><td>20%</td><td>40%</td><td>60%</td><td>80%</td><td>100%</td></tr></table>";
SkillText[8030] = "ファイタースタイルでのみ使用可能。シルバーベインラッシュ使用後の連携時のみ発動する。<br>スキル使用時に気弾を2つを消費する。<br>対象にダメージを与えると同時に一定の確率で状態異常：恐怖に陥る。<br>ターゲットが恐怖にかかる確率は気弾の数に応じて増加する。<br>スキルを使用後、[ソニッククロウ]に戻って連携することが可能である。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>8</td><td>16</td><td>24</td><td>32</td><td>40</td></tr><tr><th>物理攻撃力</th><td>300%</td><td>600%</td><td>900%</td><td>1200%</td><td>1500%</td></tr><tr><th>恐怖確率</th><td>12%</td><td>14%</td><td>16%</td><td>18%</td><td>20%</td></tr></table>";
SkillText[8031] = "対象1体にダッシュ攻撃をして、ダメージと一緒に3セルノックバックさせ、状態異常：スタンにかける。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>40</td><td>45</td><td>50</td><td>55</td><td>60</td></tr><tr><th>物理攻撃力</th><td>600%</td><td>700%</td><td>800%</td><td>900%</td><td>1000%</td></tr><tr><th>射程距離</th><td>5セル</td><td>6セル</td><td>7セル</td><td>8セル</td><td>9セル</td></tr><tr><th>スタン確率</th><td>20%</td><td>40%</td><td>60%</td><td>80%</td><td>100%</td></tr></table>";
SkillText[8032] = "ホムンクルスの回避率と攻撃速度が上昇し、通常攻撃が一定の確率で聖属性ダメージになる。<br>効果持続時間の間、[シュタールホーン]を使用すると、聖属性攻撃で発動する。<br>このスキルは、[アングリフモドス]スキルと同時に使用できない。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>60</td><td>65</td><td>70</td><td>75</td><td>80</td></tr><tr><th>FLEE</th><td>+20</td><td>+30</td><td>+40</td><td>+50</td><td>+60</td></tr><tr><th>ASPD</th><td>+10%</td><td>+14%</td><td>+18%</td><td>+22%</td><td>+26%</td></tr><tr><th>聖属性発動</th><td>20%</td><td>40%</td><td>60%</td><td>80%</td><td>100%</td></tr><tr><th>持続時間</th><td>30秒</td><td>45秒</td><td>60秒</td><td>75秒</td><td>90秒</td></tr></table>";
SkillText[8033] = "ホムンクルス自身とマスターの足下に[セーフティウォール]を詠唱する。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>80</td><td>90</td><td>100</td><td>110</td><td>120</td></tr><tr><th>持続時間</th><td>30秒</td><td>45秒</td><td>60秒</td><td>75秒</td><td>90秒</td></tr></table>";
SkillText[8034] = "対象の1体とその周辺の敵に聖属性の魔法ダメージを与える。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>60</td><td>68</td><td>76</td><td>84</td><td>92</td></tr><tr><th>魔法攻撃力</th><td>750%</td><td>1000%</td><td>1250%</td><td>1500%</td><td>1750%</td></tr><tr><th>範囲</th><td>3×3</td><td>3×3</td><td>5×5</td><td>5×5</td><td>7×7</td></tr></table>";
SkillText[8035] = "一定時間の間ホムンクルス自分の攻撃力を上昇させ、防御力と回避率が大幅に減少する。<br>また、このスキルは、[ゴールデンペルジェ]と同時に使用できない。<br>効果時間中、ホムンクルスのHPが毎秒100、SPが毎秒20ずつ減少する。<br>SPが0になると、この状態は解除される。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>60</td><td>65</td><td>70</td><td>75</td><td>80</td></tr><tr><th>ATK</th><td>+50</td><td>+100</td><td>+150</td><td>+200</td><td>+250</td></tr><tr><th>DEF</th><td>-50</td><td>-70</td><td>-90</td><td>-110</td><td>-130</td></tr><tr><th>FLEE</th><td>-60</td><td>-80</td><td>-100</td><td>-120</td><td>-140</td></tr><tr><th>持続時間</th><td>30秒</td><td>45秒</td><td>60秒</td><td>75秒</td><td>90秒</td></tr></table>";
SkillText[8036] = "グラップラースタイルでのみ使用可能。対象に近づいた後に捕獲されて関節技のスキル。<br>スキル使用後、対象とホムンクルスと相手はお互いにその場から動くことができなくなり、どちらも回避が0になる。<br>スキルを使用すると気弾が1つ消費される。ホムンクルスのSTRに応じて、攻撃力と捕獲する時間が増加する。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>20</td><td>25</td><td>30</td><td>35</td><td>40</td></tr><tr><th>物理攻撃力</th><td>100%</td><td>200%</td><td>300%</td><td>400%</td><td>500%</td></tr><tr><th>射程</th><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td></tr></table>";
SkillText[8037] = "グラップラースタイルでのみ使用可能。ティンダーブレイカー後の連携スキルでのみ使用可能。スキル使用時に気弾を1つ消費する。<br>ダメージとともに対象のSPを持続的に減少させる。<br>対象がモンスターの場合はSPを消費するかわりに追加ダメージを与える。<br>ティンダーブレイカーと同様に、持続時間の間、移動不可となり回避が0になる。<br>ホムンクルスのSTRに応じて、持続時間が増加する。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>10</td><td>20</td><td>30</td><td>40</td><td>50</td></tr></table>";
SkillText[8038] = "グラップラースタイルでのみ使用可能。CBC後の連携のスキルでのみ使用可能。スキル使用時に気弾を2つ消費する。<br>ダメージと一緒に、ターゲットを100％スタンの状態に陥れMHPと攻撃力、防御力を減らす。<br>スキル使用後はティンダーブレイカーの対象から離れることができ、回避も正常値に戻る。<br>このスキルはボスモンスターには通用しない。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>24</td><td>28</td><td>32</td><td>36</td><td>40</td></tr><tr><th>スタン確率</th><td>100%</td><td>100%</td><td>100%</td><td>100%</td><td>100%</td></tr><tr><th>MaxHP</th><td>-2%</td><td>-4%</td><td>-6%</td><td>-8%</td><td>-10%</td></tr><tr><th>ATK</th><td>-5%</td><td>-10%</td><td>-15%</td><td>-20%</td><td>-25%</td></tr><tr><th>DEF</th><td>-5%</td><td>-10%</td><td>-15%</td><td>-20%</td><td>-25%</td></tr></table>";
SkillText[8039] = "ホムンクルスがダメージを受けるたびに一定の確率でマグマが噴出して、<br>ホムンクルス周辺のすべての敵に火属性ダメージを与える。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>34</td><td>38</td><td>42</td><td>46</td><td>50</td></tr><tr><th>物理攻撃力P</th><td>100%</td><td>200%</td><td>300%</td><td>400%</td><td>500%</td></tr><tr><th>範囲</th><td>3×3</td><td>3×3</td><td>3×3</td><td>5×5</td><td>5×5</td></tr><tr><th>発動確率</th><td>3%</td><td>6%</td><td>9%</td><td>12%</td><td>15%</td></tr></table>";
SkillText[8040] = "花こう岩で構成された堅い鎧を作成、ホムンクルスと主人の防御力を一時的に向上させてダメージを減らす。<br>ただし、持続時間が終了すると、一定量のHPを失う。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>54</td><td>58</td><td>62</td><td>66</td><td>70</td></tr><tr><th>ダメージ減少</th><td>2%</td><td>4%</td><td>6%</td><td>8%</td><td>10%</td></tr><tr><th>HP損失</th><td>1%</td><td>3%</td><td>6%</td><td>10%</td><td>15%</td></tr><tr><th>持続時間</th><td>10秒</td><td>15秒</td><td>20秒</td><td>25秒</td><td>30秒</td></tr></table>";
SkillText[8041] = "溶岩を床に分散させて範囲内の敵全体にダメージを与える。<br>有効範囲内のすべてのターゲットは、一定の確率で状態異常：発火にかかるようになる。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>30</td><td>35</td><td>40</td><td>45</td><td>50</td></tr><tr><th>火属性物理攻撃力</th><td>20%</td><td>40%</td><td>60%</td><td>80%</td><td>100%</td></tr><tr><th>射程</th><td>7</td><td>7</td><td>7</td><td>7</td><td>7</td></tr><tr><th>範囲</th><td>3×3</td><td>3×3</td><td>5×5</td><td>5×5</td><td>7×7</td></tr><tr><th>発火確率</th><td>10%</td><td>20%</td><td>30%</td><td>40%</td><td>50%</td></tr></table>";
SkillText[8042] = "ホムンクルスの攻撃と主人の武器の攻撃属性が一時的に火属性に変化し、武器の攻撃力が上昇する。<br>また、攻撃時に一定の確率で[ハンマーフォール]スキルが自動的に発動する。<br>ただし、持続時間が終了すると武器が破壊される。<br>ホムンクルスのレベルが高いほど、より高い攻撃力を得るようになる。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>20</td><td>28</td><td>36</td><td>44</td><td>52</td></tr><tr><th>ATK</th><td>+10</td><td>+20</td><td>+30</td><td>+40</td><td>+50</td></tr><tr><th>持続時間</th><td>--秒</td><td>--秒</td><td>--秒</td><td>--秒</td><td>--秒</td></tr></table>";
SkillText[8043] = "火山の灰を床に分散させ、この範囲内のすべての対象に状態異常：火山灰の効果をかける。<br>火山灰の効果にかかった対象は、命中率が半分に減り、スキル使用時に50％の失敗確率を持つようになる。<br>また、範囲内では火属性攻撃に付加的なダメージを受けるようになる。<br>もし、対象が人型モンスターの場合防御力が50%低下し、<br>水属性モンスターの場合攻撃力と回避率に50％低下の効果がある。<br>火山灰の効果の持続時間はスキルレベルに応じて増える。このスキルは最大3つまでの床に設置可能。<br><table class=s-table><tr><th>Lv</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th></tr><tr><th>消費SP</th><td>60</td><td>65</td><td>70</td><td>75</td><td>80</td></tr><tr><th>射程</th><td>7</td><td>7</td><td>7</td><td>7</td><td>7</td></tr><tr><th>範囲</th><td>3×3</td><td>3×3</td><td>3×3</td><td>3×3</td><td>3×3</td></tr><tr><th>持続時間</th><td>12秒</td><td>14秒</td><td>16秒</td><td>18秒</td><td>20秒</td></tr><tr><th>火山灰確率</th><td>100%</td><td>100%</td><td>100%</td><td>100%</td><td>100%</td></tr></table>";
var homSkills = [];
homSkills[1] = [8001, 8002, 8003];
homSkills[2] = [8005, 8006, 8007];
homSkills[3] = [8009, 8010, 8011];
homSkills[4] = [8013, 8014, 8015];
homSkills[5] = homSkills[1];
homSkills[6] = homSkills[2];
homSkills[7] = homSkills[3];
homSkills[8] = homSkills[4];
homSkills[9] = [8001, 8002, 8003, 8004];
homSkills[10] = [8005, 8006, 8007, 8008];
homSkills[11] = [8009, 8010, 8011, 8012];
homSkills[12] = [8013, 8014, 8015, 8016];
homSkills[13] = homSkills[9];
homSkills[14] = homSkills[10];
homSkills[15] = homSkills[11];
homSkills[16] = homSkills[12];
homSkills[48] = [8024, 8025, 8023, 8026, 8022, 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8013, 8014, 8015];
homSkills[49] = [8031, 8032, 8033, 8034, 8035, 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8013, 8014, 8015];
homSkills[50] = [8018, 8019, 8020, 8021, 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8013, 8014, 8015];
homSkills[51] = [8043, 8041, 8040, 8039, 8042, 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8013, 8014, 8015];
homSkills[52] = [8028, 8029, 8030, 8027, 8036, 8037, 8038, 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8013, 8014, 8015];
homSkills[22] = [];
homSkills[23] = [];
homSkills[24] = [];
homSkills[25] = [];
homSkills[26] = [];
homSkills[27] = [];
homSkills[28] = [];
homSkills[29] = [];
homSkills[30] = [];
homSkills[31] = [];
homSkills[32] = [];
homSkills[33] = [];
homSkills[34] = [];
homSkills[35] = [];
homSkills[36] = [];
HomSkillTable[1] = [
	[],
	[],
	[]
];
HomSkillTable[2] = [
	[8006, 0],
	[8006, 0],
	[8006, 0],
	[8006, 0],
	[8006, 0]
];
HomSkillTable[3] = [
	[8009, 0],
	[8009, 0],
	[8009, 0],
	[8009, 0],
	[8009, 0]
];
HomSkillTable[4] = [
	[8013, 0],
	[8013, 0],
	[8013, 0],
	[8013, 0],
	[8013, 0]
];
HomSkillTable[5] = HomSkillTable[1];
HomSkillTable[6] = HomSkillTable[2];
HomSkillTable[7] = HomSkillTable[3];
HomSkillTable[8] = HomSkillTable[4];
HomSkillTable[9] = [
	[8004, 0],
	[8004, 0],
	[8004, 0],
	[8004, 0],
	[8004, 0]
];
HomSkillTable[10] = [
	[8008, 8006],
	[8008, 8006],
	[8008, 8006],
	[8008, 8006],
	[8008, 8006]
];
HomSkillTable[11] = [
	[8009, 0],
	[8009, 0],
	[8009, 0],
	[8009, 0],
	[8009, 0]
];
HomSkillTable[12] = [
	[8013, 0],
	[8013, 0],
	[8013, 0],
	[8013, 0],
	[8013, 0]
];
HomSkillTable[13] = HomSkillTable[9];
HomSkillTable[14] = HomSkillTable[10];
HomSkillTable[15] = HomSkillTable[11];
HomSkillTable[16] = HomSkillTable[12];
HomSkillTable[48] = [
	[],
	[],
	[],
	[],
	[]
];
HomSkillTable[49] = [
	[],
	[],
	[],
	[],
	[]
];
HomSkillTable[50] = [
	[],
	[],
	[],
	[],
	[]
];
HomSkillTable[51] = [
	[],
	[],
	[],
	[],
	[]
];
HomSkillTable[52] = [
	[],
	[],
	[],
	[],
	[]
];
var ASTlabel = ["AS_TABLE1", "AS_TABLE2", "AS_TABLE3", "AS_TABLE4", "AS_TABLE5"];
var SkillDefines = [];
SkillDefines[1] = {};
SkillDefines[2] = {
	8006: "SKILL_BUF1"
};
SkillDefines[3] = {
	8009: "SKILL_ATK1",
	8010: "SKILL_BUF1",
	8011: "SKILL_BUF2"
};
SkillDefines[4] = {
	8013: "SKILL_ATK1"
};
SkillDefines[5] = SkillDefines[1];
SkillDefines[6] = SkillDefines[2];
SkillDefines[7] = SkillDefines[3];
SkillDefines[8] = SkillDefines[4];
SkillDefines[9] = {
	8004: "SKILL_BUF1"
};
SkillDefines[10] = {
	8006: "SKILL_BUF1",
	8008: "SKILL_BUF2"
};
SkillDefines[11] = {
	8009: "SKILL_ATK1",
	8010: "SKILL_BUF1",
	8011: "SKILL_BUF2"
};
SkillDefines[12] = {
	8013: "SKILL_ATK1"
};
SkillDefines[13] = SkillDefines[9];
SkillDefines[14] = SkillDefines[10];
SkillDefines[15] = SkillDefines[11];
SkillDefines[16] = SkillDefines[12];
SkillDefines[48] = {
	8004: "SKILL_BUF3",
	8006: "SKILL_BUF4",
	8008: "SKILL_BUF5",
	8009: "SKILL_ATK1",
	8010: "SKILL_BUF1",
	8011: "SKILL_BUF2",
	8013: "SKILL_ATK2",
	8024: "SKILL_ATK3",
	8025: "SKILL_ATK4",
	8026: "SKILL_ATK5",
	8023: "SKILL_BUF6",
	8022: "SKILL_BUF7"
};
SkillDefines[49] = {
	8004: "SKILL_BUF3",
	8006: "SKILL_BUF4",
	8008: "SKILL_BUF5",
	8009: "SKILL_ATK1",
	8010: "SKILL_BUF1",
	8011: "SKILL_BUF2",
	8013: "SKILL_ATK2",
	8031: "SKILL_ATK3",
	8034: "SKILL_ATK4",
	8032: "SKILL_BUF6",
	8035: "SKILL_BUF7",
	8033: "SKILL_BUF8"
};
SkillDefines[50] = {
	8004: "SKILL_BUF3",
	8006: "SKILL_BUF4",
	8008: "SKILL_BUF5",
	8009: "SKILL_ATK1",
	8010: "SKILL_BUF1",
	8011: "SKILL_BUF2",
	8013: "SKILL_ATK2",
	8019: "SKILL_ATK3",
	8018: "SKILL_BUF6",
	8020: "SKILL_ATK4",
	8021: "SKILL_BUF7"
};
SkillDefines[51] = {
	8004: "SKILL_BUF3",
	8006: "SKILL_BUF4",
	8008: "SKILL_BUF5",
	8009: "SKILL_ATK1",
	8010: "SKILL_BUF1",
	8011: "SKILL_BUF2",
	8013: "SKILL_ATK2",
	8041: "SKILL_ATK3",
	8043: "SKILL_ATK4",
	8039: "SKILL_BUF6",
	8040: "SKILL_BUF7",
	8042: "SKILL_BUF8"
};
SkillDefines[52] = {
	8004: "SKILL_BUF3",
	8006: "SKILL_BUF4",
	8008: "SKILL_BUF5",
	8009: "SKILL_ATK1",
	8010: "SKILL_BUF1",
	8011: "SKILL_BUF2",
	8013: "SKILL_ATK2",
	8027: "SKILL_SWT1",
	8028: "SKILL_ATK3",
	8029: "SKILL_COM1",
	8030: "SKILL_COM2",
	8036: "SKILL_ATK4",
	8037: "SKILL_COM3",
	8038: "SKILL_COM4"
};

function SetSkillList(homid, formid, type) {
	var options = "";
	var sel_val = "";
	for (i = 0; i < homSkills[homid].length; i++) {
		var sid = homSkills[homid][i];
		if (SkillName[sid].t.match(type)) {
			options += "<option value=\"" + sid + "\">" + SkillName[sid].j + "</option>";
		}
	}
	if (options.length <= 0) {
		options = "<option value=\"0\" selected >該当スキルなし</option>";
	}
	$(formid).innerHTML = '<select class="text" id="AutoSkillType" onchange="SwitchSkill(this.value)">' + options + '</select>';
	SwitchSkill($('AutoSkillType').value);
	MakeSkillTableForm();
}

function SwitchSkill(id) {
	SkillNum = id;
	$('atk-skill').style.display = "none";
	$('buf-skill').style.display = "none";
	$('res-skill').style.display = "none";
	$('acc-skill').style.display = "none";
	$('skillicon').innerHTML = '<img src="' + image[SkillNum] + '" alt="" />';
	$('skillicon').title = SkillText[id];
	tooltip.init();
	if (SkillNum > 0) {
		putSkillSetting(HomSet[HomNum].Skills[SkillNum]);
		var names = $name('now-skillname');
		for (i = 0; i < names.length; i++) {
			names[i].innerHTML = SkillName[SkillNum].j;
		}
		$(SkillName[SkillNum].t + "-skill").style.display = "block";
		SkillPrivateParameter(SkillNum);
		if (SkillName[SkillNum].t == "atk" || SkillName[SkillNum].t == "buf") {
			$('skilltable-add').style.display = "inline-block";
			$('skilltable-no-add').style.display = "none";
		} else {
			$('skilltable-add').style.display = "none";
			$('skilltable-no-add').style.display = "inline-block";
		}
		ShowSkillTable();
	}
}

function SkillPrivateParameter(sid) {
	if (sid == 8004) {
		$('only-LIF_H').style.display = "block";
	} else {
		$('only-LIF_H').style.display = "none";
	}
	if (sid == 8014) {
		$('only-VANILMIRTH').style.display = "block";
	} else {
		$('only-VANILMIRTH').style.display = "none";
	}
	if (sid == 8029 || sid == 8030 || sid == 8037 || sid == 8038) {
		$('enable-COMBO').style.display = "none";
		$('explain-COMBO').style.display = "block";
	} else {
		$('enable-COMBO').style.display = "block";
		$('explain-COMBO').style.display = "none";
	}
	if (sid == 8018) {
		$('limit-REGION').style.display = "block";
	} else {
		$('limit-REGION').style.display = "none";
	}
	if (sid == 8027) {
		$('disable-SWITCH').style.display = "none";
		$('enable-SWITCH').style.display = "block";
	} else {
		$('disable-SWITCH').style.display = "block";
		$('enable-SWITCH').style.display = "none";
	}
	if (SkillName[sid].t == "atk") {
		if (SkillName[sid].r > 1) { //遠距離
			$('enable-longrange').style.display = "block";
		} else {
			$('enable-longrange').style.display = "none";
		}
	}
}

function MakeSkillTableForm() {
	ASTnum = 0;
	$('SkillTable-form').innerHTML = '<select class="text" id="AST_Num" onchange="ASTnum=this.value;ShowSkillTable();"><option value="0">スキルテーブル1</option><option value="1">スキルテーブル2</option><option value="2">スキルテーブル3</option><option value="3">スキルテーブル4</option><option value="4">スキルテーブル5</option></select>';
	ShowSkillTable();
}

function ShowSkillTable() {
	var ntable = HomSkillTable[HomNum][ASTnum];
	var icons = "";
	if (ntable[0] != undefined) {
		for (var i in ntable) {
			if (ntable[i] > 8000) {
				icons += '<img src="' + image[ntable[i]] + '" width="24" height="24" class="skilltable-icon" alt="' + SkillName[ntable[i]].j + '" onclick="$(\'AutoSkillType\').value=' + ntable[i] + ';SwitchSkill(' + ntable[i] + ')" />';
			}
		}
		$('skilltable').innerHTML = icons;
	} else {
		$('skilltable').innerHTML = "";
	}
	if (CheckSkillExist(HomNum, ASTnum, SkillNum)) {
		$('skilltable-add-btn').innerHTML = "テーブル" + (ASTnum - 0 + 1) + "から削除";
	} else {
		$('skilltable-add-btn').innerHTML = "テーブル" + (ASTnum - 0 + 1) + "に追加";
	}
}

function CheckSkillExist(hom, tnum, sid) {
	if (!sid) {
		sid = SkillNum;
	}
	var ntable = HomSkillTable[hom][tnum];
	for (var i in ntable) {
		if (ntable[i] == sid) {
			return i;
		}
	}
	return false;
}

function AddSkillTable(sid) {
	if (!sid) {
		sid = SkillNum;
	}
	var se = CheckSkillExist(HomNum, ASTnum, sid);
	if (!se) {
		HomSkillTable[HomNum][ASTnum].push(sid);
		$('skilltable-add-btn').innerHTML = "テーブル" + (ASTnum - 0 + 1) + "から削除";
	} else {
		if (HomSkillTable[HomNum][ASTnum].length > 1) {
			HomSkillTable[HomNum][ASTnum].splice(se, 1);
		} else {
			HomSkillTable[HomNum][ASTnum] = [];
		}
		$('skilltable-add-btn').innerHTML = "テーブル" + (ASTnum - 0 + 1) + "に追加";
	}
	ShowSkillTable();
	CheckUnSave(true);
}

function getSkillIdByAID(hom, d) {
	var sd = SkillDefines[hom];
	for (var i in sd) {
		if (d == sd[i]) {
			return i;
		}
	}
	return 0;
}
var skillname_cache = {}

function getSkillIdByName(name, lang) {
	if (skillname_cache[name]) {
		return skillname_cache[name];
	}
	for (var i in SkillName) {
		var l = "e";
		if (lang) {
			l = lang
		}
		if (SkillName[i][l] == name) {
			skillname_cache[name] = i;
			return i;
		}
	}
	return 0;
}

function getHomLabel(hid) {
	var name = homTypes[hid];
	if (HomSet[hid].HomName && HomSet[hid].HomName != DefaultName) {
		name = HomSet[hid].HomName;
	}
	return name;
}
var HomClass = (function(id) {
	this.HomName = DefaultName;
	this.ThisSetID = id;
	this.Skills = [];
	if (id > 0) {
		for (i = 0; i < homSkills[id].length; i++) {
			var sid = homSkills[id][i];
			this.Skills[sid] = {};
		}
	}
});
var DefaultSet = new HomClass(0);
DefaultSet.Skills[0] = {};

function HomSelect(id, all) {
	var options = "";
	for (i = 1; i < homTypes.length; i++) {
		if (!HomSet[i] && !all && homTypes[i]) {
			options += '<option value="' + i + '">' + homTypes[i] + '</option>';
		}
	}
	if (options.length > 0) {
		$('select-hom-area').innerHTML = "<select id=\"hom-select\">" + options + "</select>";
		$('add-hom-btn').style.color = "";
	} else {
		$('select-hom-area').innerHTML = '<select id="hom-select"><option value="0">--</option></select>';
		$('add-hom-btn').style.color = "#CCC";
	}
	if (id) {
		$('hom-select').value = id;
	}
}

function AddHom() {
	var id = $('hom-select').value;
	if (id && id > 0) {
		if (HomSet[id] == null || HomSet[id] == undefined) {
			HomSet[id] = new HomClass(id);
			HomNum = id;
			getHom(HomNum);
			HomSelect();
			CheckUnSave(true);
		}
	}
}

function DelHom(hid) {
	var id = hid.replace(/d-homid-/, "");
	if (!confirm(homTypes[id] + "の設定を消去します。\nよろしいですか？\n※一度消去した設定は復元できません。")) {
		return
	}
	HomSet[id] = null;
	delete(HomSet[id]);
	HomNum = 0;
	for (var i in HomSet) {
		if (i != id && HomSet[i] != null) {
			HomNum = i;
			break;
		}
	}
	SettingHomList();
	HomSelect(id);
	CheckUnSave(true);
}

function CopyHom(hid) {
	var id = hid.replace(/c-homid-/, "");
	if (id == HomNum) {
		return
	}
	if (!confirm(homTypes[id] + "の設定を" + homTypes[HomNum] + "にコピーします。\nよろしいですか？\n\n[" + homTypes[id] + "] ⇒ [" + homTypes[HomNum] + "]\n\n※スキルの設定はコピーしません。")) {
		return
	}
	var name = HomSet[HomNum].HomName;
	var skill = HomSet[HomNum].Skills;
	HomSet[HomNum] = null;
	delete(HomSet[HomNum]);
	HomSet[HomNum] = new HomClass(HomNum);
	for (var i in HomSet[id]) {
		if (i != "ThisSetID" && i != "HomName" && i != "Skills") {
			SettingParam(i, HomSet[id][i]);
		}
	}
	HomSet[HomNum].HomName = name;
	HomSet[HomNum].Skills = skill;
	putSetting(HomSet[HomNum]);
	CheckUnSave(true);
}

function getHom(hid) {
	var id = hid.replace(/homicon-/, "") - 0;
	if (id > 0) {
		HomNum = id;
		SettingHomList();
		SetSkillList(id, "AutoSkillType-form", "atk|buf|res|acc");
		putSetting(HomSet[id]);
		var hname = getHomLabel(id);
		$('s-hom-s-name').innerHTML = hname;
		StatusReflash();
	}
}

function SettingHomList() {
	var list = "";
	for (var i in HomSet) {
		if (HomSet[i]) {
			var id = HomSet[i].ThisSetID;
			var img = '<span class="list-icon-b"><span class="list-icon" id="homicon-' + id + '" onclick="getHom(this.id)" style="background-image:url(\'' + image[id] + '\')"></span></span>';
			var nameform = '<span class="list-hom-name" id="name-' + id + '" ondblclick="changeNameForm(this.id);">';
			var delc = '<label title="このホムンクルスの設定を削除します。" class="hom-del" id="d-homid-' + id + '" onclick="DelHom(this.id);"><img src="' + image["delete"] + '" width="16" height="16" class="mini-icon" alt="" /></label>';
			var copyc = '<label title="このホムンクルスの設定を、<br />選択中のホムンクルスの設定にコピーします。<br />※スキルの設定はコピーできません。" class="hom-copy" id="c-homid-' + id + '" onclick="CopyHom(this.id);"><img src="' + image["copy"] + '" width="16" height="16" class="mini-icon" alt="" /></label>';
			if (HomSet[i].HomName != DefaultName) {
				nameform += '<span id="fixed-name-' + id + '" class="fixed-hom-name">' + HomSet[i].HomName + '</span>';
			} else {
				nameform += '<input class="text input-hom-name" maxlength="22" style="text-align:left;" id="HomName-' + id + '" name="HomName" onchange="SettingName(this.id,this.value);" />';
			}
			nameform += '</span>';
			list += "<li>" + nameform + img + homTypes[id] + copyc + delc + "</li>";
		}
	}
	$('hom-list').innerHTML = list;
	if (HomNum > 0) {
		if ($('homicon-' + HomNum)) {
			$('homicon-' + HomNum).className = "list-icon list-icon-on";
		}
		if ($('fixed-name-' + HomNum)) {
			$('fixed-name-' + HomNum).className = "list-name-on fixed-hom-name";
		}
		$('set-hom-icon').style.background = "url('" + image[HomNum] + "') no-repeat center bottom";
		$('set-hom-name').innerHTML = homTypes[HomNum];
		tooltip.init();
	} else {
		$('set-hom-icon').style.background = "";
		$('set-hom-name').innerHTML = "";
		$('hom-list').innerHTML = '<p class="error" style="padding:10px;">設定するホムンクルスがありません。リストに追加してください。</p>';
	}
}

function changeNameForm(nid) {
	if ($(nid).innerHTML.match(/input/)) {
		return;
	}
	var id = nid.replace(/name-/, "");
	var name = "";
	if (HomSet[id].HomName != DefaultName) {
		name = HomSet[id].HomName;
	}
	$(nid).innerHTML = '<input class="text input-hom-name" maxlength="22" style="text-align:left;" id="HomName-' + id + '" name="HomName" onchange="SettingName(this.id,this.value);" onfocusout="SettingName(this.id,this.value);" />';
	$('HomName-' + id).focus();
	$('HomName-' + id).value = name;
}

function SettingName(nid, v) {
	var id = nid.replace(/HomName-/, "");
	var n = v.replace(/\"|\'| |　/g, "");
	if (n.length < 1) {
		n = DefaultName;
	}
	HomSet[id].HomName = n;
	CheckUnSave(true);
	SettingHomList();
}

function PagingHom(p) {
	var list = [];
	var j = 0;
	var n = 0;
	for (var i in HomSet) {
		list[j] = i;
		if (HomNum == i) {
			n = j;
		}
		j++;
	}
	p = p - 0;
	n = n + p;
	if (n < 0) {
		n = list.length - 1;
	} else if (n >= list.length) {
		n = 0;
	}
	var pid = list[n];
	getHom(pid);
}

function dispPaging(tf) {
	if (SetLoaded == 0) {
		return
	}
	if (tf) {
		$('prev-hom').style.display = "inline-block";
		$('next-hom').style.display = "inline-block";
	} else {
		$('prev-hom').style.display = "none";
		$('next-hom').style.display = "none";
	}
}

function putSetting(hom) {
	for (var i in DefaultSet) {
		var val = DefaultSet[i];
		if (hom[i] && hom[i] != null && hom[i] != undefined) {
			val = hom[i];
		}
		if (i == "HomName" || i == "ThisSetID") {} else if (i == "Skills") {
			var sid = $('AutoSkillType').value;
			putSkillSetting(hom[i][sid]);
		} else if (val.match(/true|false/)) {
			putTF(i, val);
		} else if (i.match(/SBR_Target/g)) {
			$(i).value = val.replace(/{|}/g, "");
		} else if (!i.match(/^skill-.*/g)) {
			$(i).value = val;
		}
	}
	for (var j in DefComSet) {
		var cid = "Com-" + j;
		var val = DefComSet[j];
		if (ComSet[j]) {
			val = ComSet[j];
		}
		if (val != "NaN") {
			if (val.match(/true|false/)) {
				putTF(cid, val);
			} else {
				$(cid).value = val;
			}
		}
	}
}

function putSkillSetting(set) {
	var dset = DefaultSet.Skills[0];
	for (var i in dset) {
		var sval = dset[i];
		if (set && set[i]) {
			sval = set[i];
		}
		var sfid = "skill-" + i;
		if (sval.match(/true|false|nil/)) {
			putTF(sfid, sval);
		} else if (sfid.match(/.*AutoSkillSPLimit(.|)/) || sfid.match(/.*BufferLevel/) || sfid.match(/.*AutoDurationCut/)) {
			var stf = $name(sfid);
			for (i = 0; i < stf.length; i++) {
				stf[i].value = sval;
			}
		} else {
			$(sfid).value = sval;
		}
	}
}

function putTF(fid, val) {
	if (fid.match(/.*-f$|.*-t$/g)) {
		if (val.match(/.*true/)) {
			$(fid).checked = true;
		} else if (val.match(/.*nil/)) {
			$(fid).checked = false;
		} else {
			$(fid).checked = false;
		}
	} else {
		if (val.match(/.*true/)) {
			$(fid + "-t").checked = true;
			$(fid + "-f").checked = false;
		} else if (val.match(/.*nil/)) {
			$(fid + "-t").checked = false;
			$(fid + "-f").checked = true;
		} else {
			$(fid + "-t").checked = false;
			$(fid + "-f").checked = true;
		}
	}
}

function getSetting(hom) {
	var homSetStr = "";
	for (var i in hom) {
		if (hom[i]) {
			if (i == "Skills") {
				var skillSet = "";
				for (var j in hom[i]) {
					for (var k in hom[i][j]) {
						skillSet += SkillName[j].e + "." + k + " = " + hom[i][j][k] + strCRLF;
					}
				}
				if (skillSet.length > 0) {
					homSetStr += "SkillSetting = function ()" + strCRLF + skillSet + "end" + strCRLF;
				}
			} else if (i.match(/FriendPriority.-[0-9]$/)) {
				var fp = i.split("-");
				var vid = fp[0] + "-v" + fp[1];
				if (hom[vid]) {
					homSetStr += fp[0] + "[" + hom[i] + "] = " + hom[fp[0] + "-v" + fp[1]] + strCRLF;
				}
			} else if (i.match(/FriendPriority.-v[0-9]$/)) {} else if (i.match(/SBR_Target/g)) {
				homSetStr += i + " = {" + hom[i] + "}" + strCRLF;
			} else if (i.match(/MobFilename/g)) {
				homSetStr += i + " = " + '"' + hom[i] + '"' + strCRLF;
			} else if (isNaN(hom[i]) && !hom[i].match(/^true$|^false$|^nil$/) && !hom[i].match(/^TRIGGER_.*/)) {
				homSetStr += i + " = " + '"' + hom[i] + '"' + strCRLF;
			} else {
				homSetStr += i + " = " + hom[i] + strCRLF;
			}
		}
	}
	return homSetStr;
}

function getAstSetting(hom) {
	var ststr = "";
	var sd = SkillDefines[hom];
	var st = HomSkillTable[hom];
	for (var i in st) {
		ststr += "ASTable[" + ASTlabel[i] + "] = {";
		var nstr = "";
		for (var j in st[i]) {
			if (st[i][j] > 8000) {
				nstr += SkillDefines[hom][st[i][j]] + ",";
			}
		}
		if (nstr.length > 0) {
			nstr = nstr.slice(0, nstr.length - 1);
		}
		ststr += nstr + "}" + strCRLF;
	}
	return ststr;
}

function printSetting() {
	var homSetStr = "";
	for (i = 1; i < homTypes.length; i++) {
		if (HomSet[i]) {
			var ifsw = "if"
			if (homSetStr.length > 0) {
				ifsw = "elseif"
			}
			homSetStr += ifsw + " MyType == " + HomSet[i].ThisSetID + " then" + strCRLF;
			homSetStr += getSetting(HomSet[i]);
			homSetStr += getAstSetting(i);
		}
	}
	if (homSetStr.length > 1) {
		homSetStr += "end" + strCRLF;
	}
	homSetStr += "--CommonSetting" + strCRLF;
	for (var i in ComSet) {
		homSetStr += i + " = " + ComSet[i] + strCRLF;
	}
	homSetStr = "function Setting()" + strCRLF + homSetStr + "end" + strCRLF;
	var lists = "";
	for (var j in HomSet) {
		if (lists.length < 1) {
			lists += j
		} else {
			lists += ", " + j;
		}
	}
	homSetStr += "SettingList = { " + lists + " }";
	return homSetStr;
}

function SettingParam(id, v, homid) {
	var hid = HomNum;
	if (hid <= 0) {
		return
	}
	if (homid) {
		hid = homid;
	}
	if (!HomSet[hid]) {
		HomSet[hid] = new HomClass(hid);
		SettingHomList();
		HomSelect();
	}
	var p = id;
	if (id.match(/.*-f$|.*-t$/g)) {
		p = id.replace(/-f$|-t$/g, "");
	}
	if (id.match(/^skill-.*/g)) {
		if (SkillNum > 0) {
			var s = p.replace(/^skill-/g, "");
			HomSet[hid]["Skills"][SkillNum][s] = v;
		}
	} else if (id.match(/^Com-.*/g)) {
		var c = p.replace(/^Com-/g, "");
		ComSet[c] = v;
	} else {
		HomSet[hid][p] = v;
	}
	CheckUnSave(true);
}

function settingForms() {
	var setPanel = $('set_main');
	var inputs = setPanel.getElementsByTagName('input');
	var selects = setPanel.getElementsByTagName('select');
	for (i = 0; i < inputs.length; i++) {
		if (!inputs[i].onchange) {
			inputs[i].onchange = function() {
				SettingParam(this.id, this.value);
			}
		}
		if (!inputs[i].onclick && inputs[i].type == "radio") {
			inputs[i].onclick = function() {
				SettingParam(this.id, this.value);
			}
		}
		var sid = inputs[i].id;
		if (sid.match(/^Com-.*/g)) {
			var sv = sid.replace(/^Com-/g, "");
			if (sid.match(/.*-f$|.*-t$/g)) {
				if ($(sid).checked) {
					sid = sv.replace(/-f$|-t$/g, "");
					DefComSet[sid] = inputs[i].value;
				}
			} else {
				DefComSet[sid] = inputs[i].value;
			}
		} else if (sid.match(/^skill-.*/g)) {
			var sv = sid.replace(/^skill-/g, "");
			if (sv.match(/.*-f$|.*-t$/g)) {
				if ($(sid).checked) {
					sv = sv.replace(/-f$|-t$/g, "");
					DefaultSet.Skills[0][sv] = inputs[i].value;
				} else {}
			} else {
				DefaultSet.Skills[0][sv] = inputs[i].value;
			}
		} else if (sid.match(/.*-f$|.*-t$/g)) {
			if ($(sid).checked) {
				sid = sid.replace(/-f$|-t$/g, "");
				DefaultSet[sid] = inputs[i].value;
			}
		} else {
			DefaultSet[sid] = inputs[i].value;
		}
	}
	for (i = 0; i < selects.length; i++) {
		selects[i].onchange = function() {
			SettingParam(this.id, this.value);
		}
		var selid = selects[i].id;
		if (selid.match(/^skill-.*/g)) {
			var sv = selid.replace(/^skill-/g, "");
			DefaultSet.Skills[0][sv] = selects[i].value;
		} else if (selid != "select-hom-area") {
			if (selid.match(/^Com-.*/g)) {
				var sv = selid.replace(/^Com-/g, "");
				DefComSet[sv] = selects[i].value;
			} else {
				DefaultSet[selid] = selects[i].value;
			}
		}
	}
}

function CheckUnSave(tf) {
	unSaved = tf;
	if (unSaved) {
		$('set-save').style.color = "#000";
	} else {
		$('set-save').style.color = "#CCC";
	}
}

function SaveSet(ret) {
	if (HomSet.length > 0 && unSaved) {
		var str = printSetting();
		if (!confirm("Set.luaに設定変更内容を保存します。")) {
			return
		}
		var pass = RO_Dir + "Set.lua";
		var objFSO = new ActiveXObject("Scripting.FileSystemObject");
		try {
			var objSetFile = objFSO.OpenTextFile(pass, ForWriting, true);
		} catch (e) {
			alert("Set.luaは他のプログラムによって使用されいるためセーブできません。\nセーブするには他のプログラムを終了してください。");
			return
		}
		objSetFile.Write(str);
		objSetFile.Close();
		CheckUnSave(false);
		if (ret) {
			return str;
		} else {
			alert("保存しました。");
		}
	}
}
var SetLoaded = 0;
var fpCnt = {};
var topHom = 0;
var endCnt = 0;
var LF = String.fromCharCode(10);
var CR = String.fromCharCode(13);

function LoadSet(file) {
	topHom = 0;
	endCnt = 0;
	fpCnt = {
		"FriendPriorityA": 1,
		"FriendPriorityD": 1
	};
	var pass = RO_Dir + "Set.lua";
	var objFSO = new ActiveXObject("Scripting.FileSystemObject");
	if (!objFSO.FileExists(pass) && !file) {
		$('set-alert').innerHTML = "ディレクトリにSet.luaがありません。設定作成後、保存すると新規作成します。";
		$('select-hom-field').style.display = "block";
		$('hom-list').innerHTML = '<p class="error" style="padding:10px;">設定したいホムンクルスを選択し、追加ボタンを押してリストに追加してください。</p>';
		CheckUnSave(false);
		return
	} else {
		$('set-alert').style.display = "none";
	}
	if (file) {
		var set_date = file.split(/\r\n|\r|\n/);
		for (var i in set_date) {
			Data2Form(set_date[i]);
		}
	} else {
		var objSetFile = objFSO.OpenTextFile(pass, ForReading);
		if (!objSetFile.AtEndOfStream) {
			do {
				var str = objSetFile.ReadLine();
				Data2Form(str);
			} while (objSetFile.AtEndOfStream == false);
		}
		objSetFile.Close();
		CheckUnSave(false);
	}
	if (topHom > 0) {
		getHom(topHom);
	}
	HomSelect();
	$('select-hom-field').style.display = "block";
	SetLoaded = 1;
}

function Data2Form(str) {
	if (str.length > 0) {
		var t = str.split(" ");
		if (t[1] == "MyType") {
			HomNum = t[3];
			if (topHom == 0) {
				topHom = HomNum;
			}
		} else if (t[0] == "function" || t[0].match(/^end/) || t[0].match(/^SkillSetting/) || t[0].match(/^SettingList/)) {} else if (t[0].match(/^\-\-CommonSetting/)) {
			endCnt++;
		} else if (t[0].match(/FriendPriority.*/)) {
			var fp = t[0].split(/\[|\]/g);
			var c = fpCnt[fp[0]];
			SettingParam(fp[0] + "-" + c, fp[1]);
			SettingParam(fp[0] + "-v" + c, t[2]);
			fpCnt[fp[0]]++;
		} else if (t[0].match(/.*\..*/)) {
			var sk = t[0].split(".");
			var sid = getSkillIdByName(sk[0], "e");
			if (sid > 0) {
				SkillNum = sid;
				SettingParam("skill-" + sk[1], t[2]);
			}
		} else if (t[0].match(/ASTable\[/)) {
			var stnum = t[0].replace(/ASTable\[AS_TABLE|\]| /g, "");
			stnum = stnum - 1;
			var st = t[2].replace(/{|}/g, "");
			st = st.split(",");
			HomSkillTable[HomNum][stnum] = [];
			if (st.length > 0) {
				for (var i in st) {
					HomSkillTable[HomNum][stnum][i] = getSkillIdByAID(HomNum, st[i]);
				}
			}
		} else {
			var fid = t[0];
			var v = t[2].replace(/\"/g, "");
			v = v.replace(/{|}/g, "");
			if (endCnt > 0) {
				fid = "Com-" + fid;
			}
			SettingParam(fid, v);
		}
	}
}

function ReloadSet(file) {
	if (unSaved && !file) {
		if (!confirm("設定変更内容が保存されていません。\n変更前のデータを再読み込みしますか？")) {
			return
		}
	}
	HomSet = [];
	HomNum = 0;
	SkillNum = 0;
	LoadSet(file);
	setMenuTab('s_top', 0);
}
var lastmob = 3000;
var data = [];
var list;
var t;
var nowMap = 0;
var nowList = ["1003"];
MobUnSaved = false;
MobListEdit = true;
for (num = 0; num <= lastmob; num++) {
	data[num] = [];
	data[num][0] = 3;
	data[num][1] = 6;
	data[num][2] = 0;
	data[num][3] = 0;
	data[num][4] = 0;
	data[num][5] = 0;
	data[num][6] = 0;
	data[num][7] = 0;
	data[num][8] = 0;
}

function MakeSelectBox() {
	var shtml = "";
	shtml = "<div>ダンジョン：<select name=location id=\"location\" class=text onChange=\"Output(LocationList,$('location').value);\">;"
	shtml += "<option value=\"0\">クリア</option>"
	for (i = 1; i < (LocationList.length); i++) {
		if (LocationList[i]) {
			var selopt = LocationList[i].split(",");
			shtml += "<option value=\"" + i + "\">" + selopt[1] + "</option>"
		}
	}
	shtml += "</select>　フィールド：<select name=field id=\"field\" class=text onChange=\"Output(FieldList,$('field').value);\">"
	shtml += "<option value=\"0\">クリア</option>";
	for (i = 1; i < (FieldList.length); i++) {
		if (FieldList[i]) {
			var selopt = FieldList[i].split(",");
			shtml += "<option value=\"" + i + "\">" + selopt[1] + "</option>";
		}
	}
	shtml += "</select>　おすすめ狩場：<select name=choice id=\"choice\" class=text onChange=\"Output(PickedList,$('choice').value);\">";
	shtml += "<option value=\"0\">クリア</option>"
	for (i = 1; i < (PickedList.length); i++) {
		if (PickedList[i]) {
			var selopt = PickedList[i].split(",");
			shtml += "<option value=\"" + i + "\">" + selopt[1] + "</option>";
		}
	}
	shtml += "</select>";
	shtml += '</div>';
	shtml += '<div style="width:390px;margin-top:5px;float:left;">Mob検索： <input size="40" type="text" id="search" onKeyup="SearchMob($(\'search\').value,event.keyCode);">　<button onClick="SearchMob($(\'search\').value,event.keyCode);blur();" class="button" style="padding:1px 5px;"><img src="' + image["search"] + '" width="16" height="16" class="mini-icon" />検索</button></div>';
	var swtf = ["checked", ""];
	if (!MobListEdit) {
		swtf = ["", "checked"];
	}
	shtml += '<div style="width:335px;padding:6px 0;"><input type="radio" id="ms-switch-t" name="ms-switch" value="true" onclick="MsSwitch(true)" ' + swtf[0] + ' /><label for="ms-switch-t" onclick="MsSwitch(true)"> 設定編集</label> <input type="radio" id="ms-switch-f" name="ms-switch" onclick="MsSwitch(false)" value="false" ' + swtf[1] + ' /><label for="ms-switch-f" onclick="MsSwitch(false)"> ダメージ計算</label></div>';
	shtml += '<div style="clear:both;"></div>';
	$("area-selects").innerHTML = shtml;
}

function MsSwitch(tf) {
	MobListEdit = tf;
	Output(nowList, nowMap);
}

function MobFileSelect() {
	var options = "";
	for (var i in HomSet) {
		var name = getHomLabel(i);
		var filename = "Mob";
		if (HomSet[i].MobFilename && HomSet[i].MobFilename != filename) {
			filename = HomSet[i].MobFilename;
		}
		options += '<option value="' + i + '">' + name + "(" + filename + ".lua)" + '</option>';
	}
	if (options.length < 1) {
		options = '<option value="1">' + "Mob.lua" + '</option>';
	}
	options = '<select id="mob-filename" onchange="LoadMob()"><option value="0">--選択してください</option>' + options + '</select>';
	return options;
}

function MakeForm() {
	var selects = MobFileSelect();
	var formdata = '<table>';
	formdata = formdata + '<tr><td><span style="font-size:10pt;">ファイルをロード：</span>' + selects + '</td>';
	formdata = formdata + '<td><span class="button" onClick="SaveIni();" style="margin-left:5px;" id="mob-save"><img src="' + image["save"] + '" width="16" height="16" class="mini-icon" />Mob設定を保存</span>';
	formdata = formdata + '<span class="button" style="margin-left:15px;" onClick="ResetData();"><img src="' + image["refresh"] + '" width="16" height="16" class="mini-icon" />データをクリア</span></td></tr>';
	formdata = formdata + '<tr><td style="font-size:10pt; text-align:left;">ファイル名 ： <span id="filename" style="color:#0000FF"></span></td><td style="font-size:10pt; text-align:left;padding-left:5px;width:400px;">データベース最終更新日：<span style="color:#3333cc;">' + infomsg[3] + '</span></td></tr></table>';
	$("fileinput").innerHTML = formdata;
	$("dataarea").innerHTML = '<p class="error">※編集するMob設定ファイルをロードしてください。</p>';
}

function GetList(alist, id) {
	var opt = alist[id].split(",");
	var r = [];
	for (i = 0; i < (opt.length - 2); i++) {
		r[i] = opt[i + 2];
	}
	return r;
}

function SearchMob(na, inst) {
	var s_list = ["", ""];
	var key = na.replace(/[ ]/g, "")
	if (key.length < 1 || key.indexOf("N", 0) > -1 || key.indexOf("/", 0) > -1 || key.indexOf("end", 0) > -1) {
		return
	} else if (inst != 0 && key.length <= 1) {
		return
	}
	for (i = 0; i < lastmob - 3; i++) {
		if (MobList[i] != undefined) {
			var str = MobList[i];
			if (str.indexOf("<font color=#ff8080>", 0) > -1) {
				str = str.replace(/[<font color=#ff8080>]/g, "");
			} else if (str.indexOf("X_", 0) > -1) {
				str = str.replace(/[X_]/g, "");
			}
			if ((key.length < 3 && str.indexOf(key, 0) == 0) || (key.length >= 3 && str.indexOf(key, 0) >= 0)) {
				var addnum = "" + (i + 1001);
				if (s_list[1].length > 1) {
					addnum = "," + addnum;
				}
				s_list[1] = s_list[1] + addnum;
			}
		}
	}
	if (s_list[1].length > 1) {
		s_list[1] = "0,検索結果," + s_list[1];
		Output(s_list, 1);
	}
}

function DataInput() {
	var i;
	var setting = 8;
	for (i = 0; i < t; i++) {
		var mobID = list[i] - 1001;
		data[mobID][0] = $("selAct" + mobID).value;
		data[mobID][1] = $("selSkill" + mobID).value;
		data[mobID][2] = $("selAs" + mobID).value;
		data[mobID][8] = $("selAsC" + mobID).value;
		data[mobID][3] = $("selCast" + mobID).value;
		data[mobID][4] = $("selSkillt" + mobID).value;
		data[mobID][5] = $("selRank" + mobID).value;
		data[mobID][7] = $("selMild" + mobID).value;
	}
}

function DataInput2(id) {
	data[id][0] = $("selAct" + id).value;
	data[id][1] = $("selSkill" + id).value;
	data[id][2] = $("selAs" + id).value;
	data[id][8] = $("selAsC" + id).value;
	data[id][3] = $("selCast" + id).value;
	data[id][4] = $("selSkillt" + id).value;
	data[id][5] = $("selRank" + id).value;
	data[id][7] = $("selMild" + id).value;
	CheckMobUnSave(true);
}
var t = 0;

function Output(clist, intX) {
	var i;
	var html;
	nowMap = intX;
	nowList = clist;
	if (MobListEdit) {
		html = '<table border="0" cellspacing="1" id="sorter"><tbody><tr><th>Mob名</th><th>対応</th><th>スキルレベル</th><th>AS確率</th><th>AS回数</th><th style="font-size:8pt;">詠唱妨害</th><th style="font-size:8pt;">スキルT</th><th>優先度</th><th>手加減</th><th><span style="font-size:8pt;">平均時間</span></th></tr>';
	} else {
		html = '<table border=0 bgcolor=#b0b0ff cellspacing=1 id="sim-result"><tbody><tr><th>Mob名</th><th>平均与Dmg</th><th>平均与MDmg</th><th>平均被Dmg</th><th>平均被MDmg</th><th>要Flee<span style="font-size:8pt;">(回避)</span></th><th>要Hit<span style="font-size:8pt;">(命中)</span></th></tr>';
	}
	if (intX > 0) {
		list = GetList(clist, intX);
		t = list.length;
		for (i = 0; i < t; i++) {
			var mobID = list[i] - 1001;
			if (mobID >= 0) {
				if (MobListEdit) {
					if (MobList[mobID].indexOf("NoData", 0) == -1) {
						html = html + '<tr><td style="text-align:left;padding-left:0.5em" class="r' + i % 2 + '"><label title="' + (mobID - 0 + 1001) + '">' + MobList[mobID] + '</label></td><td class="r' + i % 2 + '">';
						html = html + '<select id="selAct' + mobID + '" onChange="DataInput2(' + mobID + ');"><option value="4">先制攻撃<option value="3" selected>普通<option value="2">無視する<option value="1">完全無視<option value="0">逃げる敵</select>';
						html = html + '</td><td class="r' + i % 2 + '">';
						html = html + '<select id="selSkill' + mobID + '" onChange="DataInput2(' + mobID + ');"><option value="0">スキルなし<option value="1">Lv1<option value="2">Lv2<option value="3">Lv3<option value="4">Lv4<option value="5">Lv5<option value="6" selected>基本Lv';
						html = html + '<option value="7">Full Lv1<option value="8">Full Lv2<option value="9">Full Lv3<option value="10">Full Lv4<option value="11">Full Lv5<option value="12">Full 基本Lv</select>';
						html = html + '</td><td class="r' + i % 2 + '">';
						html = html + '+<input type="text" id="selAs' + mobID + '" value="0" size="3" maxlength="3" class="text" onChange="DataInput2(' + mobID + ');">％</td><td class="r' + i % 2 + '">';
						html = html + '<input type="text" id="selAsC' + mobID + '" value="0" size="2" maxlength="2" class="text" onChange="DataInput2(' + mobID + ');">回</td><td class="r' + i % 2 + '">';
						html = html + '<select id="selCast' + mobID + '" onChange="DataInput2(' + mobID + ');"><option value="0">OFF<option value="1">ON</select>';
						html = html + '</td><td class="r' + i % 2 + '">';
						html = html + '<select id="selSkillt' + mobID + '" onChange="DataInput2(' + mobID + ');"><option value="0">1</option><option value="1">2</option><option value="2">3</option><option value="3">4</option><option value="4">5</option></select>';
						html = html + '</td><td class="r' + i % 2 + '">' + '<select type="text" id="selRank' + mobID + '" class="text" onChange="DataInput2(' + mobID + ');"><option value="0">0<option value="1">1<option value="2">2<option value="3">3<option value="4">4<option value="5">5<option value="6">6<option value="7">7<option value="8">8<option value="9">9<option value="10">10';
						html = html + '<option value="11">11<option value="12">12<option value="13">13<option value="14">14<option value="15">15<option value="16">16<option value="17">17<option value="18">18<option value="19">19<option value="20">20</select>';
						html = html + '</td><td class="r' + i % 2 + '"><select id="selMild' + mobID + '" onChange="DataInput2(' + mobID + ');"><option value="0">なし<option value="1">あり</select>';
						html = html + '</td><td style="text-align:right" class="r' + i % 2 + '">' + (data[mobID][6] / 1000) + '秒</td></tr>';
					}
				} else {
					var ht = MobFileHom;
					var res = ShowMobData(mobID + 1001, ht, true);
					if (MobList[mobID].indexOf("NoData", 0) == -1) {
						html = html + '<tr><td style="text-align:left;width:240px;padding-left:0.5em;" class="r' + i % 2 + '">' + MobList[mobID] + '</td><td class="r' + i % 2 + '">';
						html = html + res[0] + '</td><td class="r' + i % 2 + '">';
						html = html + res[1] + '</td><td class="r' + i % 2 + '">';
						html = html + res[2] + '</td><td class="r' + i % 2 + '">';
						html = html + res[3] + '</td><td class="r' + i % 2 + '">';
						html = html + res[4] + '</td><td class="r' + i % 2 + '">';
						html = html + res[5] + '</td></tr>';
					}
				}
			}
		}
	}
	html = html + "</tbody></table>";
	$("dataarea").innerHTML = html;
	if (intX > 0 && MobListEdit) {
		for (i = 0; i < t; i++) {
			var mobID = list[i] - 1001;
			if (mobID >= 0) {
				if (MobList[mobID].indexOf("NoData", 0) == -1) {
					$("selAct" + mobID).value = data[mobID][0];
					$("selSkill" + mobID).value = data[mobID][1];
					$("selAs" + mobID).value = data[mobID][2];
					$("selAsC" + mobID).value = data[mobID][8];
					$("selCast" + mobID).value = data[mobID][3];
					$("selSkillt" + mobID).value = data[mobID][4];
					$("selRank" + mobID).value = data[mobID][5];
					$("selMild" + mobID).value = data[mobID][7];
				}
			}
		}
	}
}

function ResetData() {
	if (MobLoaded == 1) {
		var addalert = "";
		if (MobUnSaved) {
			addalert = "変更が保存されていませんが、";
		}
		if (confirm("読み込み中のデータをクリアします。\n" + addalert + "よろしいですか？")) {
			for (num = 0; num <= lastmob; num++) {
				data[num][0] = 3;
				data[num][1] = 6;
				data[num][2] = 0;
				data[num][3] = 0;
				data[num][4] = 0;
				data[num][5] = 0;
				data[num][6] = 0;
				data[num][7] = 0;
				data[num][8] = 0;
			}
			MobLoaded = 0;
			$("dataarea").innerHTML = "";
			$("area-selects").innerHTML = "";
			MobFileName = "";
			MobFilePass = "";
			MakeForm();
		}
	}
}
var MobLoaded = 0;
var MobFileName = "";
var MobFilePass = "";

function LoadMob(file) {
	var tt = ["1003"];
	if ($("mob-filename").value == 0) {
		return
	}
	var hid = $("mob-filename").value;
	var mfilename = "Mob.lua";
	if (HomSet[hid]) {
		if (HomSet[hid].MobFilename && HomSet[hid].MobFilename != mfilename) {
			mfilename = HomSet[hid].MobFilename + ".lua";
		}
	}
	if (MobFileName == mfilename && !file) {
		MobFileHom = hid;
		Output(nowList, nowMap);
		return
	} else if (MobLoaded == 1 && !file && MobUnSaved) {
		if (confirm(MobFileName + "が未保存です。\n変更を破棄して他のファイルをロードしますか？") == false) {
			return;
		}
	}
	MobFileHom = hid;
	MobFileName = mfilename;
	for (num = 0; num <= lastmob; num++) {
		data[num][0] = 3;
		data[num][1] = 6;
		data[num][2] = 0;
		data[num][3] = 0;
		data[num][4] = 0;
		data[num][5] = 0;
		data[num][6] = 0;
		data[num][7] = 0;
		data[num][8] = 0;
	}
	MobFilePass = RO_Dir + MobFileName;
	if (MobFilePass.length < 1) {
		$("area-selects").innerHTML = "";
		$("dataarea").innerHTML = '<p class="error">※ファイルが選択されていません。</p>';
		return
	}
	$("filename").innerHTML = MobFileName;
	if (file) {
		var m_date = file.split(CR + LF);
		for (i = 0; i < m_date.length; i++) {
			Mobdata2Form(m_date[i]);
		}
		CheckMobUnSave(true);
	} else {
		var objFSO = new ActiveXObject("Scripting.FileSystemObject");
		if (!objFSO.FileExists(MobFilePass)) {
			$("area-selects").innerHTML = "";
			$("dataarea").innerHTML = '<p class="error">※' + MobFileName + 'ファイルが存在しません。</p>';
			return
		}
		var objInFile = objFSO.OpenTextFile(MobFilePass, ForReading);
		try {
			do {
				if (!objInFile.AtEndOfStream) {
					strLine = objInFile.ReadLine();
					Mobdata2Form(strLine);
				}
			} while (!objInFile.AtEndOfStream);
		} catch (e) {
			coccoAlert("ファイルオープンエラー");
			return 0;
		}
		objInFile.Close();
	}
	MakeSelectBox();
	Output(nowList, nowMap);
	MobLoaded = 1;
	$("location").value = 0;
	$("field").value = 0;
	$("choice").value = 0;
	if (!file) {
		CheckMobUnSave(false);
	}
}

function Mobdata2Form(str) {
	if (str.length > 0) {
		var index = str.substr(4, 4) - 1001;
		if (index <= lastmob) {
			var v = str.split(" ");
			data[index][0] = v[1];
			data[index][1] = v[3];
			data[index][2] = v[5];
			data[index][3] = v[7];
			data[index][4] = v[9];
			data[index][6] = v[13];
			if (v[11] > 20) {
				data[index][5] = v[11] - 20;
				data[index][7] = 1;
			} else {
				data[index][5] = v[11];
			}
			data[index][8] = v[15];
		}
	}
}

function SaveIni() {
	if (MobLoaded == 1) {
		if (!MobUnSaved) {
			return
		}
		blnAnswer = confirm(MobFileName + "を保存しますか？");
		if (blnAnswer) {
			var objFSO = new ActiveXObject("Scripting.FileSystemObject");
			try {
				var objFile = objFSO.OpenTextFile(MobFilePass, 2, true);
			} catch (e) {
				alert(MobFileName + "は他のプログラムによって使用されいるためセーブできません。<br />セーブするには他のプログラムを終了してください。");
				return 0;
			}
			var plus;
			for (i = 0; i < lastmob; i++) {
				plus = data[i][5];
				if (data[i][7] != 0) {
					if (data[i][5] == 0) {
						data[i][5] = 1;
					}
					plus = 20 + (data[i][5] - 0);
				}
				var id = i + 1001;
				if (data[i][0] != 3 || data[i][1] != 6 || data[i][2] != 0 || data[i][3] != 0 || data[i][4] != 0 || data[i][5] != 0 || data[i][6] != 0 || data[i][8] != 0) {
					objFile.WriteLine("Mob[" + id + "]={ " + data[i][0] + " , " + data[i][1] + " , " + data[i][2] + " , " + data[i][3] + " , " + data[i][4] + " , " + plus + " , " + data[i][6] + " , " + data[i][8] + " }");
				}
			}
			objFile.Close();
			MobUnSaved = false;
			alert("保存しました。");
			CheckMobUnSave(false);
		}
	} else {
		alert("Mob.luaファイルがロードされていません");
	}
}

function CheckMobUnSave(tf) {
	MobUnSaved = tf;
	if (MobUnSaved) {
		$('mob-save').style.color = "#000";
	} else {
		$('mob-save').style.color = "#CCC";
	}
}
var HomStatus = [];
for (i = 1; i <= 16; i++) {
	HomStatus[i] = [];
}
var MobDataDisp;
var SkillTimer = [];
ACT_list = ["<font color=#ff0000>退避</font>", "<font color=#ff8040>完全無視</font>", "<font color=#ff8040>無視</font>", "<font color=#008000>通常</font>", "<font color=#008000>先制攻撃</font>"]
SKILL_list = ["なし　", "Lv1　", "Lv2　", "Lv3　", "Lv4　", "Lv5　", "基本Lv　", "Lv1(Full)　", "Lv2(Full)　", "Lv3(Full)　", "Lv4(Full)　", "Lv5(Full)　", "基本Lv(Full)　"]
CAST_list = ["なし", "<font color=#aa00aa>あり</font>"]
EDIT_list = ["", "友達登録", "オートスキル使用設定", "スキルレベル設定", "無視設定", "先制攻撃設定", "スキルテーブル設定", "詠唱妨害設定", "優先度設定", "手加減設定", "フルスキル設定", "一括友達登録", "友達リストクリア"]

function HomList(id) {
	return PlayerList[6000 + Number(id)];
}
Mob_Type = ["無形", "不死", "動物", "植物", "昆虫", "魚類", "悪魔", "人間", "天使", "竜族"];
Mob_Elem = ["無", "水", "地", "火", "風", "毒", "聖", "闇", "念", "死"];
Mob_Elem_Color = ["#808080", "#0000FF", "#339900", "#FF0000", "#CCCC00", "#990099", "#88BBEE", "#333333", "#8080E0", "#660000"];
Mob_Size = ["未定義", "小", "中", "大"];

function GetMob(actor) {
	var mobid;
	mobid = actor - 1001;
	if (MobList[mobid] && !MobList[mobid].match(/NoData/)) {
		return MobList[mobid];
	} else {
		return "NoData (ID:" + actor + ") ";
	}
}

function GetMobType(type, elem, elv, size) {
	var typet = "--/--/--";
	if (Mob_Type[type] && Mob_Size[size] && Mob_Elem[elem]) {
		typet = "<b>" + Mob_Type[type] + "</b>/<b>" + Mob_Size[size] + "</b>/<b>";
		typet = typet + "<span style=\"color:" + Mob_Elem_Color[elem] + ";\">" + Mob_Elem[elem] + elv + "</span></b>";
	}
	return typet;
}

function PlayerConfig() {
	var sam = [];
	for (i = 0; i < PlayerList.length - 1; i++) {
		var m = PlayerList[i].split(",");
		sam[m[0]] = m[1];
	}
	PlayerList = sam;
}

function GetSkillCount(count) {
	if (count == 0) {
		return "∞";
	} else {
		return count;
	}
}

function GetHit(mhit) {
	if (mhit - 5) {
		return mhit - 5;
	} else {
		return mhit;
	}
}

function GetFleeP(mflee, hom) {
	var fp;
	if (HomSet[hom] && HomSet[hom]["FLEE"] && !mflee.match(/\-\-/)) {
		/*var hfp = HomSet[hom]["FLEE"]-0+100; //20140318 +100分がなくなったかも */
		var hfp = HomSet[hom]["FLEE"] - 0;
		fp = hfp - mflee;
		fp = fp + 95;
		if (fp > 5) {
			if (fp <= 95) {
				fp;
			} else {
				fp = 95;
			}
		} else {
			fp = 5;
		}
		fp = "(" + fp + "%)"
	} else {
		fp = "";
	}
	return fp;
}

function GetHitP(mhit, hom) {
	var fp;
	if (HomSet[hom] && HomSet[hom]["HIT"] && !mhit.match(/\-\-/)) {
		var hfp = HomSet[hom]["HIT"];
		fp = hfp - mhit;
		fp = fp + 100;
		if (fp > 5) {
			if (fp <= 95) {
				;
			} else {
				fp = 95;
			}
		} else {
			fp = 5;
		}
		fp = "(" + fp + "%)"
	} else {
		fp = "";
	}
	return fp;
}

function Calc_Str(lv, c_atk, c_hit, c_cri) {
	var c_str;
	c_str = 3 * (c_atk - Math.floor(lv / 10)) - (c_hit - lv - 150) - (c_cri - 1) * 3;
	return Math.ceil(c_str);
}

function Calc_Int(lv, c_matk, c_hit, c_cri) {
	var c_int;
	c_int = (3 * (c_matk - lv) - Math.floor(lv / 10) * 6 - (c_hit - lv - 150) - (c_cri - 1) * 3) / 4;
	return Math.ceil(c_int);
}

function Calc_Matk(c_int) {
	var c_matk = 0;
	if (c_int == "err" || c_int == "NaN") {
		c_matk = "err";
	} else {
		c_matk = c_int + Math.pow(Math.floor(c_int / 5), 2);
	}
	return (c_matk);
}
var ElemList = [];
ElemList[0] = [100, 100, 100, 100];
ElemList[1] = [87.5, 75, 75, 75];
ElemList[2] = [81.25, 75, 75, 75];
ElemList[3] = [81.25, 75, 75, 75];
ElemList[4] = [81.25, 75, 75, 75];
ElemList[5] = [100, 100, 100, 75];
ElemList[6] = [75, 50, 25, 0];
ElemList[7] = [100, 75, 50, 25];
ElemList[8] = [100, 100, 100, 100];
ElemList[9] = [106.25, 112.5, 106.25, 100];

function ShowMobData(mobid, homid, list) {
	var hom = Number(homid);
	var homStatus = [];
	if (HomSet[hom]) {
		homStatus = HomSet[hom];
	}
	if (!MobData[mobid - 1000]) {
		return false;
	}
	var md = (MobData[mobid - 1000].substr(0, MobData[mobid - 1000].length - 1)).split(",");
	$('mdata_name').innerHTML = GetMob(mobid);
	$('mdata_lv').innerHTML = "<span style=color:#006600;>" + md[1] + "</span>";
	$('mdata_hp').innerHTML = "<span style=color:#006600;>" + md[2] + "</span>";
	$('mdata_type').innerHTML = GetMobType(md[5], md[6], md[7], md[8]);
	$('mdata_atk').innerHTML = "<span style=color:#CC0033;>" + md[9] + "～" + md[10] + "</span>";
	$('mdata_def').innerHTML = "<span style=color:#003366;>" + md[11] + "+" + md[12] + "</span>";
	$('mdata_matk').innerHTML = "<span style=color:#CC0033;>" + md[13] + "～" + md[14] + "</span>";
	$('mdata_mdef').innerHTML = "<span style=color:#003366;>" + md[15] + "+" + md[16] + "</span>";
	$('mdata_flee').innerHTML = "<span style=color:#0033CC;font-weight:bold;>" + md[19] + GetFleeP(md[19], hom) + "</span>";
	$('mdata_hit').innerHTML = "<span style=color:#009933;font-weight:bold;>" + GetHit(md[18]) + GetHitP(md[18], hom) + "</span>";
	$('mdata_exp').innerHTML = "<span style=color:#996600;font-weight:bold;>" + md[3] + "</span>";
	$('mdata_jexp').innerHTML = "<span style=color:#996600;font-weight:bold;>" + md[4] + "</span>";
	var aspdv = md[17];
	$('mdata_aspd').innerHTML = "<span style=color:#006600;>" + aspdv + "</span>";
	var aveatk;
	var dmg;
	var matk;
	var mdmg;
	var flee;
	var hit;
	if (homStatus["ATK"] && homStatus["HIT"] && homStatus["CRI"] && homStatus["LV"]) {
		var c_atk = Number(homStatus["ATK"]);
		var c_hit = Number(homStatus["HIT"]);
		var c_lv = Number(homStatus["LV"]);
		var c_cri = Number(homStatus["CRI"]);
		var c_str = Calc_Str(c_lv, c_atk, c_hit, c_cri);
		var b_atk = c_str + (c_hit - c_lv - 150) / 5 + (c_cri - 1) + (c_lv / 4);
		var t_atk = b_atk + c_atk;
		var aveatk = (t_atk + t_atk + 150) / 2;
		aveatk = aveatk * 450 / (md[11] - 0 + 450) - md[12];
		if (aveatk < 1) {
			aveatk = 1
		};
		aveatk = Math.round(aveatk);
		if ((homid == 9 || homid == 13) && homStatus["MATK"]) {
			var c_int = Calc_Int(Number(homStatus["MATK"])) + 60;
			var c_matk = Calc_Matk(c_int);
			var mcatk = mcatk * 450 / (md[11] - 0 + 450) - md[12];
			if (mcatk < 1) {
				mcatk = 1
			};
			aveatk = aveatk + "(M:" + Math.round(mcatk) + ")";
		}
		aveatk = "<span style=color:#003366;>" + aveatk + "</span>";
	} else {
		aveatk = "--"
	}
	if (homStatus["DEF"]) {
		var c_def = Number(homStatus["DEF"]);
		dmg = Math.round((Number(md[9]) + Number(md[10])) / 2) - c_def;
		if (dmg < 1) {
			dmg = 1
		};
		dmg = "<span style=color:#CC0033;>" + dmg + "</span>";
	} else {
		dmg = "--"
	}
	if (homid == 4 || homid == 8 || homid == 12 || homid == 16) {
		if (homStatus["MATK"]) {
			var c_matk = Number(homStatus["MATK"]);
			matk = c_matk * (113.5 / (113.5 + Number(md[15]))) - Number(md[16]);
			if (dmg < 0) {
				dmg = 0
			};
			matk = matk * (ElemList[md[6]][md[7] - 1] / 100);
			matk = "<span style=color:#003366;>" + Math.round(matk * 5) + "(5hit)</span>";
		} else {
			matk = "--"
		}
	} else {
		matk = "--"
	}
	if (homStatus["MDEF"]) {
		var c_mdef = Number(homStatus["MDEF"]);
		mdmg = Math.round((Number(md[13]) + Number(md[14])) / 2) - c_mdef;
		if (mdmg < 1) {
			mdmg = 1;
		}
		mdmg = "<span style=color:#CC0033;>" + mdmg + "</span>";
	} else {
		mdmg = "--"
	}
	if (homStatus["FLEE"]) {
		flee = "<span style=color:#0033CC;>" + md[19] + " " + GetFleeP(md[19], hom) + "</span>";
	} else {
		flee = "--"
	}
	if (homStatus["HIT"]) {
		hit = "<span style=color:#009933;>" + GetHit(md[18]) + " " + GetHitP(md[18], hom) + "</span>";
	} else {
		hit = "--"
	}
	$('mydata_atk').innerHTML = aveatk;
	$('mydata_def').innerHTML = dmg;
	$('mydata_matk').innerHTML = matk;
	$('mydata_mdef').innerHTML = mdmg;
	var res_a = [aveatk, matk, dmg, mdmg, flee, hit];
	MobDataDisp = new Date();
	if (list) {
		return res_a;
	}
}

function GetMsg(argV) {
	var msg
	if (argV[0] <= -1) {
		return "<font color=#0000ff>AIをロードしました</font>";
	} else if (argV[0] == 0) {
		msg = "待機中"
		if (argV[1] == 1) {
			msg = msg + "　<font color=#ff0000>(先行)</font>";
		}
		msg = msg + "　<font color=#6666cc>[現在地:(" + argV[2] + "," + argV[3] + ")]</font>";
		return msg
	} else if (argV[0] == 1) {
		return "追従中";
	} else if (argV[0] == 2) {
		return "<font color=#0000ff>" + GetMob(argV[1]) + "</font> をターゲット";
	} else if (argV[0] == 3 || argV[0] == 26) {
		if ($('mdata').style.display == "block") {
			ShowMobData(argV[1], argV[9]);
		}
		msg = "<font color=#0000ff><b>" + GetMob(argV[1]) + "</b>の設定</font><br>" + "対応 : " + ACT_list[argV[2]];
		if (argV[0] == 26) {
			msg = msg + "<font color=#806000>(遠)</font>";
		}
		msg = msg + "　詠唱妨害 : " + CAST_list[argV[4]] + "　スキルテーブル : <font color=#ff0080>" + (argV[5] - 0 + 1) + "</font><br>";
		if (argV[9] == 3 || argV[9] == 4 || argV[9] == 7 || argV[9] == 8 || argV[9] == 11 || argV[9] == 12 || argV[9] == 15 || argV[9] == 16) {
			msg = msg + "オートスキル : <font color=#0080c0>" + SKILL_list[argV[3]] + "</font>　確率 : <font color=#0080c0>" + argV[8] + "</font>％　　回数 : <font color=#0080c0>" + GetSkillCount(argV[10]) + "</font><br>";
		}
		msg = msg + "索敵優先度 : <font color=#8000ff>" + argV[6] + "</font>　　平均戦闘時間 : <font color=#8000ff>" + argV[7] / 1000 + "</font>秒";
		return msg;
	} else if (argV[0] == 12) {
		return "休憩中" + "　<font color=#6666cc>[現在地:(" + argV[2] + "," + argV[3] + ")]</font>";
	} else if (argV[0] == 13) {
		return "追従中(休憩中)";
	} else if (argV[0] == 25) {
		return "<font color=#0000ff>退避中！</font>";
	} else if (argV[0] == 28) {
		return "先行移動中";
	} else if (argV[0] == 30) {
		return "スリープモード";
	} else if (argV[0] == 200) {
		if (!SkillTimer[argV[1]]) {
			SkillTimer[argV[1]] = [argV[1], argV[2], new Date()];
			return S_Shout_List[argV[1] - 8000];
		} else if ((new Date() - SkillTimer[argV[1]][2]) / 1000 > 2) {
			SkillTimer[argV[1]] = [argV[1], argV[2], new Date()];
		}
		return -1;
	} else if (argV[0] == 201) {
		if (SkillTimer[argV[1]]) {
			SkillTimer[argV[1]] = null;
		}
		return -1;
	} else if (argV[0] == 99) {
		return "<font color=#ff0000>エラーが発生しました！！<br />AIを停止しております。<br />再開するにはAIをリロードしてください。</font>";
	} else if (argV[0] == 100) {
		msg = EDIT_list[argV[1]] + "<br>";
		if (argV[1] == 1) {
			msg = msg + "ID : <font color=#0000ff>" + argV[3];
			if (argV[3] < 100000) {
				msg = msg + "</font>　種族 : <font color=#008000>" + HomList(argV[4]) + "</font><br>";
			} else {
				msg = msg + "</font>　職業 : <font color=#008000>" + PlayerList[argV[4]] + "</font><br>";
			}
			if (argV[2] == 1) {
				msg = msg + "　を友達に登録しました";
			} else {
				msg = msg + "　を友達リストから削除しました";
			}
		} else if (argV[1] == 2) {
			msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font>";
			if (argV[2] == 0) {
				msg = msg + " に対してスキルを使いません";
			} else {
				msg = msg + " に対してスキルを使います";
			}
		} else if (argV[1] == 3) {
			msg = "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対して常にオートスキル" + SKILL_list[argV[2]];
		} else if (argV[1] == 4) {
			if (argV[2] == 3) {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対して 通常設定 で対応";
			} else {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> は " + ACT_list[argV[2]] + " する敵に設定";
			}
		} else if (argV[1] == 5) {
			if (argV[2] == 3) {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対して 通常設定 で対応";
			} else {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> は " + ACT_list[argV[2]] + " する敵に設定";
			}
		} else if (argV[1] == 6) {
			msg = "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対してスキルテーブル" + (argV[2] - 0 + 1) + "を使用する";
		} else if (argV[1] == 7) {
			if (argV[2] == 1) {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対して詠唱妨害<font color=#ff8040>する</font>";
			} else {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対して詠唱妨害しない";
			}
		} else if (argV[1] == 9) {
			if (argV[2] > 20) {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対して手加減<font color=#ff8040>する</font>";
			} else {
				msg = msg + "<font color=#0000ff>" + GetMob(argV[4]) + "</font> に対して手加減しない";
			}
		} else if (argV[1] == 11) {
			msg = "画面内の味方キャラクターを全て友達登録しました";
		} else if (argV[1] == 12) {
			msg = "友達リストを全消去しました";
		} else {
			msg = "Msg Error";
		}
		return msg
	} else if (argV[0] == 101) {
		if (argV[1] == 2) {
			msg = "サーチング<br><font color=#ff0000>";
			if (argV[2] == 0) {
				if (argV[3] > 100000) {
					msg = msg + PlayerList[argV[4]] + "</font>";
				} else if (argV[7] == 1) {
					msg = msg + GetMob(argV[4]) + "</font>";
				} else if (argV[7] == 0) {
					msg = msg + PlayerList(argV[4]) + "</font>";
				}
			} else {
				msg = msg + HomList(argV[4]) + "</font>";
			}
			msg = msg + " を X : <font color=#0000ff>" + argV[5] + "</font> Y : <font color=#0000ff>" + argV[6] + "</font> 地点に発見！";
			return msg;
		} else if (argV[1] == 6) {
			msg = "オーナーチェンジ<br>"
			if (argV[2] == 1) {
				if (argV[3] < 100000) {
					msg = msg + "ID : <font color=#ff0000>" + argV[3] + "</font>　種族 : <font color=#008000>" + HomList(argV[4]) + "</font><br>を一時的に主人にしました";
				} else {
					msg = msg + "ID : <font color=#ff0000>" + argV[3] + "</font>　職業 : <font color=#008000>" + PlayerList[argV[4]] + "</font><br>を一時的に主人にしました";
				}
			} else {
				msg = msg + "主人を戻しました";
			}
			return msg
		}
	} else if (argV[0] == 102) {
		var modemsg
		if (argV[2] = 0) {
			modemsg = "基本セット : ";
		} else {
			modemsg = "セット" + argV[2] + " : ";
		}
		modemsg = modemsg + "<font color=#0000ff>" + homTypes[argV[1]] + "モード</font>";
		return modemsg;
	}
}

function GetFood(h, m, s) {
	var flag;
	flag = 0;
	if (s < 30) {
		if (h > 0 && m == 0) {
			flag = 1;
		} else if (m != 0 && (m % 10) == 0) {
			flag = 1;
		}
	}
	if (flag == 1) {
		var fMsg;
		if (HomType == 1 || HomType == 5 || HomType == 9 || HomType == 13) {
			fMsg = "pet";
		} else if (HomType == 2 || HomType == 6 || HomType == 10 || HomType == 14) {
			fMsg = "zargon";
		} else if (HomType == 3 || HomType == 7 || HomType == 11 || HomType == 15) {
			fMsg = "garet";
		} else if (HomType == 4 || HomType == 8 || HomType == 12 || HomType == 16) {
			fMsg = "scell";
		} else if (HomType == 48) {
			fMsg = "salad";
		} else if (HomType == 49) {
			fMsg = "snow";
		} else if (HomType == 50) {
			fMsg = "ringop";
		} else if (HomType == 51) {
			fMsg = "lg";
		} else if (HomType == 52) {
			fMsg = "niku";
		}
		if (!PreIconImg.food) {
			PreIconImg.food = new Image();
			PreIconImg.food.src = image[fMsg];
		}
		$('food-icon').src = PreIconImg.food.src;
		$('food-icon').style.display = "block";
	} else {
		$('food-icon').style.display = "none";
	}
	RingAlarm(flag);
}
OnSkill = [];
OnSkill[8001] = ["h_h", 0, 0, 0, 0, 0];
OnSkill[8002] = ["e_a", 40, 35, 30, 25, 20];
OnSkill[8003] = ["b_s", 0, 0, 0, 0, 0];
OnSkill[8004] = ["m_c", 60, 180, 300];
OnSkill[8005] = ["cas", 0, 0, 0, 0, 0];
OnSkill[8006] = ["d_f", 40, 35, 30, 25, 20];
OnSkill[8007] = ["a_s", 0, 0, 0, 0, 0];
OnSkill[8008] = ["b_l", 60, 180, 300];
OnSkill[8009] = ["m_l", 0, 0, 0, 0, 0];
OnSkill[8010] = ["f_m", 60, 55, 50, 45, 40];
OnSkill[8011] = ["o_s", 60, 55, 50, 45, 40];
OnSkill[8012] = ["sbr", 0, 0, 0, 0, 0];
OnSkill[8013] = ["cap", 0, 0, 0, 0, 0];
OnSkill[8014] = ["c_v", 0, 0, 0, 0, 0];
OnSkill[8015] = ["c_i", 0, 0, 0, 0, 0];
OnSkill[8016] = ["b_e", 0, 0, 0, 0, 0];
OnSkill[8017] = ["noskill", 0, 0, 0, 0, 0];
OnSkill[8018] = ["s_l", 20, 30, 40, 50, 60];
OnSkill[8019] = ["n_p", 0, 0, 0, 0, 0];
OnSkill[8020] = ["p_m", 12, 14, 16, 18, 20];
OnSkill[8021] = ["p_k", 30, 27.5, 25, 22.5, 20];
OnSkill[8022] = ["l_r", 36, 42, 48, 54, 60];
OnSkill[8023] = ["o_b", 10, 30, 50, 70, 90];
OnSkill[8024] = ["e_c", 0, 0, 0, 0, 0];
OnSkill[8025] = ["x_s", 0, 0, 0, 0, 0];
OnSkill[8026] = ["s_b", 9, 12, 15, 18, 21];
OnSkill[8027] = ["s_ch", 0, 0, 0, 0, 0];
OnSkill[8028] = ["s_cr", 0, 0, 0, 0, 0];
OnSkill[8029] = ["s_r", 0, 0, 0, 0, 0];
OnSkill[8030] = ["m_fr", 0, 0, 0, 0, 0];
OnSkill[8031] = ["s_h", 0, 0, 0, 0, 0];
OnSkill[8032] = ["g_f", 30, 45, 60, 75, 90];
OnSkill[8033] = ["sw", 30, 45, 60, 75, 90];
OnSkill[8034] = ["h_s", 0, 0, 0, 0, 0];
OnSkill[8035] = ["a_m", 30, 45, 60, 75, 90];
OnSkill[8036] = ["t_b", 0, 0, 0, 0, 0];
OnSkill[8037] = ["cbc", 0, 0, 0, 0, 0];
OnSkill[8038] = ["eqc", 0, 0, 0, 0, 0];
OnSkill[8039] = ["m_fl", 30, 45, 60, 75, 90];
OnSkill[8040] = ["g_a", 10, 15, 20, 25, 30];
OnSkill[8041] = ["l_s", 0, 0, 0, 0, 0];
OnSkill[8042] = ["pyr", 60, 90, 120, 150, 180];
OnSkill[8043] = ["v_a", 12, 14, 16, 18, 20];
SkillDelay = [];
SkillDelay[8001] = ["h_h", 2, 2, 2, 2, 2];
SkillDelay[8002] = ["e_a", 35, 35, 35, 35, 35];
SkillDelay[8003] = ["b_s", 0, 0, 0, 0, 0];
SkillDelay[8004] = ["m_c", 60, 180, 300];
SkillDelay[8005] = ["cas", 0, 0, 0, 0, 0];
SkillDelay[8006] = ["d_f", 30, 30, 30, 30, 30];
SkillDelay[8007] = ["a_s", 0, 0, 0, 0, 0];
SkillDelay[8008] = ["b_l", 60, 180, 300];
SkillDelay[8009] = ["m_l", 2, 2, 2, 2, 2];
SkillDelay[8010] = ["f_m", 30, 27.5, 25, 22.5, 20];
SkillDelay[8011] = ["o_s", 30, 27.5, 25, 22.5, 20];
SkillDelay[8012] = ["sbr", 0, 0, 0, 0, 0];
SkillDelay[8013] = ["cap", 1.8, 2.1, 2.4, 2.7, 3];
SkillDelay[8014] = ["c_v", 2, 2, 2, 2, 2];
SkillDelay[8015] = ["c_i", 0, 0, 0, 0, 0];
SkillDelay[8016] = ["b_e", 0, 0, 0, 0, 0];
SkillDelay[8017] = ["noskill", 0, 0, 0, 0, 0];
SkillDelay[8018] = ["s_l", 2, 2, 2, 2, 2];
SkillDelay[8019] = ["n_p", 0, 4, 8, 12, 16];
SkillDelay[8020] = ["p_m", 2, 2, 2, 2, 2];
SkillDelay[8021] = ["p_k", 0, 30, 30, 60, 60];
SkillDelay[8022] = ["l_r", 0, 0, 0, 0, 0];
SkillDelay[8023] = ["o_b", 1, 1, 1, 1, 1];
SkillDelay[8024] = ["e_c", 1, 1.5, 2, 2.5, 3];
SkillDelay[8025] = ["x_s", 1, 2, 2, 3, 3];
SkillDelay[8026] = ["s_b", 1, 1, 1, 1, 1];
SkillDelay[8027] = ["s_ch", 1, 1, 1, 1, 1];
SkillDelay[8028] = ["s_cr", 1, 2, 3, 4, 5];
SkillDelay[8029] = ["s_r", 1, 1, 1, 1, 1];
SkillDelay[8030] = ["m_fr", 0, 0, 0, 0, 0];
SkillDelay[8031] = ["s_h", 1, 1, 1, 1, 1];
SkillDelay[8032] = ["g_f", 1, 1, 1, 1, 1];
SkillDelay[8033] = ["sw", 1, 1, 1, 1, 1];
SkillDelay[8034] = ["h_s", 1, 1, 2, 2, 3];
SkillDelay[8035] = ["a_m", 1, 1, 1, 1, 1];
SkillDelay[8036] = ["t_b", 2, 3, 4, 5, 6];
SkillDelay[8037] = ["cbc", 0, 0, 0, 0, 0];
SkillDelay[8038] = ["eqc", 300, 300, 300, 300, 300];
SkillDelay[8039] = ["m_fl", 1, 1, 1, 1, 1];
SkillDelay[8040] = ["g_a", 10, 15, 20, 25, 30];
SkillDelay[8041] = ["l_s", 1, 1, 2, 2, 3];
SkillDelay[8042] = ["pyr", 1, 1, 1, 1, 1];
SkillDelay[8043] = ["v_a", 300, 300, 300, 300, 300];
SkillCasting = [];
SkillCasting[8001] = ["h_h", 0, 0, 0, 0, 0];
SkillCasting[8002] = ["e_a", 0, 0, 0, 0, 0];
SkillCasting[8003] = ["b_s", 0, 0, 0, 0, 0];
SkillCasting[8004] = ["m_c", 0, 0, 0, 0, 0];
SkillCasting[8005] = ["cas", 0, 0, 0, 0, 0];
SkillCasting[8006] = ["d_f", 0, 0, 0, 0, 0];
SkillCasting[8007] = ["a_s", 0, 0, 0, 0, 0];
SkillCasting[8008] = ["b_l", 0, 0, 0, 0, 0];
SkillCasting[8009] = ["m_l", 0, 0, 0, 0, 0];
SkillCasting[8010] = ["f_m", 0, 0, 0, 0, 0];
SkillCasting[8011] = ["o_s", 0, 0, 0, 0, 0];
SkillCasting[8012] = ["sbr", 0, 0, 0, 0, 0];
SkillCasting[8013] = ["cap", 0, 0, 0, 0, 0];
SkillCasting[8014] = ["c_v", 0, 0, 0, 0, 0];
SkillCasting[8015] = ["c_i", 0, 0, 0, 0, 0];
SkillCasting[8016] = ["b_e", 0, 0, 0, 0, 0];
SkillCasting[8017] = ["noskill", 0, 0, 0, 0, 0];
SkillCasting[8018] = ["s_l", 0, 0, 0, 0, 0];
SkillCasting[8019] = ["n_p", 0, 0, 0, 0, 0];
SkillCasting[8020] = ["p_m", 0, 0, 0, 0, 0];
SkillCasting[8021] = ["p_k", 0, 0, 0, 0, 0];
SkillCasting[8022] = ["l_r", 0, 0, 0, 0, 0];
SkillCasting[8023] = ["o_b", 0, 0, 0, 0, 0];
SkillCasting[8024] = ["e_c", 0, 0, 0, 0, 0];
SkillCasting[8025] = ["x_s", 0, 0, 0, 0, 0];
SkillCasting[8026] = ["s_b", 0, 0, 0, 0, 0];
SkillCasting[8027] = ["s_ch", 0, 0, 0, 0, 0];
SkillCasting[8028] = ["s_cr", 0, 0, 0, 0, 0];
SkillCasting[8029] = ["s_r", 0, 0, 0, 0, 0];
SkillCasting[8030] = ["m_fr", 0, 0, 0, 0, 0];
SkillCasting[8031] = ["s_h", 0, 0, 0, 0, 0];
SkillCasting[8032] = ["g_f", 0, 0, 0, 0, 0];
SkillCasting[8033] = ["sw", 0, 0, 0, 0, 0];
SkillCasting[8034] = ["h_s", 0, 0, 0, 0, 0];
SkillCasting[8035] = ["a_m", 0, 0, 0, 0, 0];
SkillCasting[8036] = ["t_b", 0, 0, 0, 0, 0];
SkillCasting[8037] = ["cbc", 0, 0, 0, 0, 0];
SkillCasting[8038] = ["eqc", 0, 0, 0, 0, 0];
SkillCasting[8039] = ["m_fl", 0, 0, 0, 0, 0];
SkillCasting[8040] = ["g_a", 0, 0, 0, 0, 0];
SkillCasting[8041] = ["l_s", 0, 0, 0, 0, 0];
SkillCasting[8042] = ["pyr", 0, 0, 0, 0, 0];
SkillCasting[8043] = ["v_a", 0, 0, 0, 0, 0];
var PreIconImg = [];

function GetSkillIcon() {
	var st = "<ul id=\"active-skills\">";
	var s_id = homSkills[HomType];
	var slist = $('active-skills');
	var ls = slist.getElementsByTagName("li");
	for (i = 0; i <= s_id.length - 1; i++) {
		if (SkillTimer[s_id[i]]) {
			if (!PreIconImg[s_id[i]]) {
				PreIconImg[s_id[i]] = new Image();
				PreIconImg[s_id[i]].src = image[s_id[i]];
			}
			var sdt = new Date();
			sdt = (sdt - SkillTimer[s_id[i]][2]) / 1000;
			sdt = Math.floor(sdt);
			var slv = SkillTimer[s_id[i]][1]
			var n_skilltime = Number(OnSkill[s_id[i]][slv]);
			var n_delaytime = Number(SkillDelay[s_id[i]][slv]);
			var n_castingtime = Number(SkillCasting[s_id[i]][slv]);
			var stime = n_skilltime;
			sdt = sdt - n_castingtime;
			if (stime > sdt) {
				var sstt = Math.ceil(stime - sdt);
				var tmcolor = "#00F";
				var tmfw = "400";
				if (sstt <= 15 || sstt <= stime * 0.2) {
					tmcolor = "#F00";
					tmfw = "700";
				}
				if (ls[i].getElementsByTagName("img")[0].src != PreIconImg[s_id[i]].src) {
					ls[i].getElementsByTagName("img")[0].src = PreIconImg[s_id[i]].src;
				}
				if (sdt >= 0) {
					ls[i].getElementsByTagName("img")[0].style.filter = "none";
					ls[i].getElementsByTagName("span")[0].innerHTML = sstt;
					ls[i].getElementsByTagName("span")[0].style.color = tmcolor;
					ls[i].getElementsByTagName("span")[0].style.fontWeight = tmfw;
				} else {
					ls[i].getElementsByTagName("img")[0].style.filter = "alpha(opacity=50)";
					ls[i].getElementsByTagName("span")[0].innerHTML = n_skilltime;
				}
				ls[i].style.display = "block";
			} else if (n_skilltime < n_delaytime && n_delaytime > sdt && sdt >= 0) {
				var sstt = Math.ceil(n_delaytime - sdt);
				if (ls[i].getElementsByTagName("img")[0].src != PreIconImg[s_id[i]].src) {
					ls[i].getElementsByTagName("img")[0].src = PreIconImg[s_id[i]].src;
				}
				ls[i].getElementsByTagName("img")[0].style.filter = "gray";
				ls[i].getElementsByTagName("span")[0].innerHTML = sstt;
				ls[i].getElementsByTagName("span")[0].style.color = "#999";
				ls[i].getElementsByTagName("span")[0].style.fontWeight = "700";
				ls[i].style.display = "block";
			} else {
				SkillTimer[s_id[i]] = null;
				ls[i].style.display = "none";
			}
		} else {
			if (ls[i]) {
				ls[i].style.display = "none";
			}
		}
	}
}
var ait_switch = 0;
var ait = "";
var tMsg, t_h, t_m, t_s;
var strMsg;
var unloadcnt = 0;
var HomType;
HomType = 0;
var DispLog = "";
MsgFilename = "Message.lua";

function disp() {
	if (LoadFlag == 0) {
		unloadcnt++;
		if (unloadcnt > 45) {
			LoadingError();
		}
		return
	}
	var msgpass = RO_Dir + MsgFilename;
	var objFSO = new ActiveXObject("Scripting.FileSystemObject");
	if (!objFSO.FileExists(msgpass)) {
		$('message-display').innerHTML = "<span class=\"error\">Message.luaがありません。<br />初回起動がまだか、ディレクトリが正しく指定されていない、またはメッセージモニタ使用設定になっていません。</span>";
		return
	}
	var objFile = objFSO.OpenTextFile(msgpass, ForReading, false);
	if (objFile.AtEndOfStream == false) {
		strLine = objFile.ReadLine();
		var v = strLine.split(" ");
		strMsg = GetMsg(v);
		if (v[9] == 0 || v[9] != HomType) {
			HomType = v[9];
			var path;
			path = "<img src=\"" + image[HomType] + ".\" onClick=\"StatusSwitch();\" />";
			$("graphic").innerHTML = path;
			if (HomSet[HomType] && HomSet[HomType] != null && HomSet[HomType].HomName != DefaultName) {
				var nname = HomSet[HomType].HomName;
				$("hom-name").innerHTML = nname;
				$("hom-name-u").innerHTML = nname;
				if (nname.length > 9) {
					$("hom-name").style.fontSize = 10;
					$("hom-name-u").style.fontSize = 10;
				} else {
					$("hom-name").style.fontSize = 12;
					$("hom-name-u").style.fontSize = 12;
				}
			} else {
				$("hom-name").innerHTML = "";
				$("hom-name-u").innerHTML = "";
			}
			if (HomType >= 1 && HomType <= 16) {
				StatusReflash(HomType);
			}
		}
		if ((v[0] == -2 && ait == "") || v[0] == -1) {
			ait_switch = 1;
			ait = new Date();
			SkillTimer = [];
			GetSound();
		}
		if (v[0] != 3) {
			var m_diff = new Date();
			m_diff = (m_diff - MobDataDisp) / 1000;
			if (m_diff > 5) {
				$('mdata_name').innerHTML = "--";
				$('mdata_lv').innerHTML = "--";
				$('mdata_hp').innerHTML = "--";
				$('mdata_type').innerHTML = "--/--/--";
				$('mdata_atk').innerHTML = "--～--";
				$('mdata_def').innerHTML = "--+--";
				$('mydata_atk').innerHTML = "--";
				$('mydata_def').innerHTML = "--";
				$('mdata_matk').innerHTML = "--～--";
				$('mdata_mdef').innerHTML = "--+--";
				$('mydata_matk').innerHTML = "--";
				$('mydata_mdef').innerHTML = "--";
				$('mdata_flee').innerHTML = "--";
				$('mdata_hit').innerHTML = "--";
				$('mdata_exp').innerHTML = "--";
				$('mdata_jexp').innerHTML = "--";
				$('mdata_aspd').innerHTML = "--";
			}
		}
	}
	objFile.Close();
	if (LoadFlag == 1) {
		if (!strMsg) {
			strMsg = "<span class=\"error\">Message.luaが正しいフォーマットで出力されていません。Message.luaを一旦削除するか、メッセージモニタを使用する設定をしてログインしなおしてください。</span>";
		} else if (strMsg == -1) {
			strMsg = DispLog;
		}
		$('message-display').innerHTML = strMsg;
		DispLog = strMsg;
		if (v != undefined) {
			if (HomSet[HomType] && HomSet[HomType] != null && HomSet[HomType].HomName != DefaultName) {
				$("hom-s-name").innerHTML = HomSet[HomType].HomName;
			} else {
				$("hom-s-name").innerHTML = HomList(Number(v[9]));
			}
		}
	} else {}
	if (ait_switch == 1) {
		var n_diff = new Date();
		n_diff = (n_diff - ait) / 1000;
		t_h = Math.floor(n_diff / 3600);
		t_m = Math.floor(Math.floor(n_diff / 60) % 60);
		t_s = Math.floor(n_diff % 60);
		tMsg = t_h + ":"
		if (t_m < 10) {
			tMsg = tMsg + "0";
		}
		tMsg = tMsg + t_m + ":";
		if (t_s < 10) {
			tMsg = tMsg + "0";
		}
		tMsg = "稼働時間 " + tMsg + t_s;
		GetFood(t_h, t_m, t_s);
		$("aitimer").innerHTML = tMsg;
		GetSkillIcon();
	}
}
setInterval("disp()", 200);

function TimerReset() {
	if (ait_switch == 1) {
		ait = new Date();
	}
}
SpeakerSwitch = true;
AlarmExist = false;

function GetSound() {
	var soundpass = RO_Dir + "alarm.wav";
	var sound = $("speaker");
	var objFSO = new ActiveXObject("Scripting.FileSystemObject");
	if (objFSO.FileExists(soundpass)) {
		sound.style.background = "url('" + image["speaker_on"] + "') no-repeat center center";
		sound.style.cursor = "pointer";
		AlarmExist = true;
	} else {}
}

function SpeakerCheck() {
	if (AlarmExist) {
		var sound = $("speaker");
		if (SpeakerSwitch) {
			SpeakerSwitch = false;
			sound.style.background = "url('" + image["speaker_off"] + "') no-repeat center center";
		} else {
			SpeakerSwitch = true;
			sound.style.background = "url('" + image["speaker_on"] + "') no-repeat center center";
		}
	}
}
RingFlag = true;

function RingAlarm(flag) {
	var tf = false;
	if (SpeakerSwitch && AlarmExist) {
		if (RingFlag && flag == 1) {
			tf = true;
			RingFlag = false;
		} else if (flag == 0) {
			RingFlag = true;
		}
		if (tf) {
			var alarm = $("alarm");
			var soundpass = RO_Dir + "alarm.wav";
			alarm.loop = 1;
			alarm.src = soundpass;
		}
	}
}
var S_Shout_List = ["スキル名", "治癒の手！", "緊急回避！", " ", "メンタルチェンジ！", "キャスリング！", "ディフェンス！", " ", "ブラッドラスト！", "ムーンライト！", "フリットムーブ！", "オーバードスピード！", "S.B.R.44！", "カプリス！", "カオティックベネディクション！", " ", "バイオエクスプロージョン！", "", "サモンレギオン！", "ニードルオブパラライズ！", "ポイズンミスト！", "ペインキラー！", "再生の光！", "オーバードブースト！", "イレイサーカッター！", "ゼノスラッシャー！", "サイレントブリーズ！", "スタイルチェンジ！", "ソニッククロウ！", "シルバーベインラッシュ！", "ミッドナイトフレンジ！", "シュタールホーン！", "ゴールデンペルジェ！", "シュタインワンド！", "ハイリエージュスタンジェ！", "アングリフスモドス！", "ティンダーブレイカー！", "C.B.C！", "E.Q.C！", "マグマフロー！", "グラニティックアーマー！", "ラーヴァスライド！", "パイロクラスティック！", "ボルカニックアッシュ！"];
var SkillMessageFile = "SkillMSG.txt"
var smfFSO = new ActiveXObject("Scripting.FileSystemObject");
if (smfFSO.FileExists(SkillMessageFile) == true) {
	smfFile = smfFSO.OpenTextFile(SkillMessageFile, ForReading, false)
	if (smfFile.AtEndOfStream == false) {
		var sv;
		var smfLine;
		var sIndex;
		sIndex = 1;
		while (smfFile.AtEndOfStream == false) {
			smfLine = smfFile.ReadLine();
			sv = smfLine.split(" ");
			S_Shout_List[sIndex] = sv[1];
			sIndex = sIndex + 1
		}
		smfFile.close();
	}
}

function DataSwitch() {
	var dispon = "block";
	var dispoff = "none";
	if ($('atkdmg_off').style.display == "none") {
		dispon = "none";
		dispoff = "block";
	}
	$('atkdmg_on').style.display = dispon;
	$('atkdmg_off').style.display = dispoff;
	$('matkdmg_on').style.display = dispon;
	$('matkdmg_off').style.display = dispoff;
}

function StatusSwitch() {
	if ($('message-status').style.display != "none") {
		$('message-display').style.display = "block";
		$('message-status').style.display = "none";
	} else {
		$('message-display').style.display = "none";
		$('message-status').style.display = "block";
	}
	StatusReflash(HomType);
}

function StatusReflash(hid) {
	if (!hid) {
		hid = HomType;
	}
	if (HomSet[hid]) {
		if (HomSet[hid]["LV"]) {
			$('hom_lv').value = HomSet[hid]["LV"];
		} else {
			$('hom_lv').value = ""
		}
		if (HomSet[hid]["ATK"]) {
			$('hom_atk').value = HomSet[hid]["ATK"];
		} else {
			$('hom_atk').value = ""
		}
		if (HomSet[hid]["DEF"]) {
			$('hom_def').value = HomSet[hid]["DEF"];
		} else {
			$('hom_def').value = ""
		}
		if (HomSet[hid]["HIT"]) {
			$('hom_hit').value = HomSet[hid]["HIT"];
		} else {
			$('hom_hit').value = ""
		}
		if (HomSet[hid]["CRI"]) {
			$('hom_cri').value = HomSet[hid]["CRI"];
		} else {
			$('hom_cri').value = ""
		}
		if (HomSet[hid]["MATK"]) {
			$('hom_matk').value = HomSet[hid]["MATK"];
		} else {
			$('hom_matk').value = ""
		}
		if (HomSet[hid]["MDEF"]) {
			$('hom_mdef').value = HomSet[hid]["MDEF"];
		} else {
			$('hom_mdef').value = ""
		}
		if (HomSet[hid]["FLEE"]) {
			$('hom_flee').value = HomSet[hid]["FLEE"];
		} else {
			$('hom_flee').value = ""
		}
		if (HomNum == hid) {
			if (HomSet[hid]["LV"]) {
				$('LV').value = HomSet[hid]["LV"];
			} else {
				$('LV').value = ""
			}
			if (HomSet[hid]["ATK"]) {
				$('ATK').value = HomSet[hid]["ATK"];
			} else {
				$('ATK').value = ""
			}
			if (HomSet[hid]["DEF"]) {
				$('DEF').value = HomSet[hid]["DEF"];
			} else {
				$('DEF').value = ""
			}
			if (HomSet[hid]["HIT"]) {
				$('HIT').value = HomSet[hid]["HIT"];
			} else {
				$('HIT').value = ""
			}
			if (HomSet[hid]["CRI"]) {
				$('CRI').value = HomSet[hid]["CRI"];
			} else {
				$('CRI').value = ""
			}
			if (HomSet[hid]["MATK"]) {
				$('MATK').value = HomSet[hid]["MATK"];
			} else {
				$('MATK').value = ""
			}
			if (HomSet[hid]["MDEF"]) {
				$('MDEF').value = HomSet[hid]["MDEF"];
			} else {
				$('MDEF').value = ""
			}
			if (HomSet[hid]["FLEE"]) {
				$('FLEE').value = HomSet[hid]["FLEE"];
			} else {
				$('FLEE').value = ""
			}
		}
	}
	if (HomSet[HomNum]) {
		if (HomNum > 0) {
			if (HomSet[HomNum]["LV"]) {
				if (HomSet[HomNum]["HIT"]) {
					$('DEX').innerHTML = HomSet[HomNum]["HIT"] - HomSet[HomNum]["LV"] - 150;
					if (HomSet[HomNum]["ATK"] && HomSet[HomNum]["CRI"]) {
						$('STR').innerHTML = Calc_Str(HomSet[HomNum]["LV"], HomSet[HomNum]["ATK"], HomSet[HomNum]["HIT"], HomSet[HomNum]["CRI"]);
					} else {
						$('STR').innerHTML = "--";
					}
					if (HomSet[HomNum]["MATK"] && HomSet[HomNum]["CRI"]) {
						$('INT').innerHTML = Calc_Int(HomSet[HomNum]["LV"], HomSet[HomNum]["MATK"], HomSet[HomNum]["HIT"], HomSet[HomNum]["CRI"]);
					} else {
						$('INT').innerHTML = "--";
					}
				} else {
					$('DEX').innerHTML = "--";
					$('STR').innerHTML = "--";
					$('INT').innerHTML = "--";
				}
				if (HomSet[HomNum]["FLEE"]) {
					/*20150226 FLEEステータス表示が+100正常表示されるようになったので、AGI計算時は表示FLEE-100*/
					/*$('AGI').innerHTML = HomSet[HomNum]["FLEE"] - HomSet[HomNum]["LV"] - Math.floor(HomSet[HomNum]["LV"]/10);*/
					$('AGI').innerHTML = (HomSet[HomNum]["FLEE"] - 100) - HomSet[HomNum]["LV"] - Math.floor(HomSet[HomNum]["LV"] / 10);
					if (HomSet[HomNum]["DEF"]) {
						/*20150226 FLEEステータス表示が+100正常表示されるようになったので、VIT計算時は表示FLEE-100*/
						/*$('VIT').innerHTML = Math.floor((Math.floor(HomSet[HomNum]["DEF"] - Math.floor(HomSet[HomNum]["LV"]/2)) - Math.floor((HomSet[HomNum]["FLEE"] - HomSet[HomNum]["LV"])/2))/2) - Math.floor(HomSet[HomNum]["LV"]/10);*/
						$('VIT').innerHTML = Math.floor((Math.floor(HomSet[HomNum]["DEF"] - Math.floor(HomSet[HomNum]["LV"] / 2)) - Math.floor(((HomSet[HomNum]["FLEE"] - 100) - HomSet[HomNum]["LV"]) / 2)) / 2) - Math.floor(HomSet[HomNum]["LV"] / 10);
					} else {
						$('VIT').innerHTML = "--";
					}
				} else {
					$('AGI').innerHTML = "--";
					$('VIT').innerHTML = "--";
				}
			} else {
				$('AGI').innerHTML = "--";
				$('DEX').innerHTML = "--";
				$('STR').innerHTML = "--";
				$('VIT').innerHTML = "--";
				$('INT').innerHTML = "--";
			}
			if (HomSet[HomNum]["CRI"]) {
				$('LUK').innerHTML = (HomSet[HomNum]["CRI"] - 1) * 3;;
			} else {
				$('LUK').innerHTML = "--";
			}
		}
	}
}
var FriendUnSaved = false;
var FriendList = [];
var FriendClass = (function(id, job, state) {
	this.id = id;
	this.name = DefaultName;
	this.job = job;
	this.state = state;
});

function SwitchFriend(fid, tf) {
	var ar = "停止中";
	if (tf) {
		ar = "登録中";
	}
	for (var i in FriendList) {
		if (FriendList[i].id == fid) {
			FriendList[i].state = tf;
		}
	}
	CheckFriendUnSave(true);
	putFriendLists();
}

function SwitchFriendAll(tf) {
	var ar = "停止中";
	if (tf) {
		ar = "登録中";
	}
	if (!confirm("すべて" + ar + "にしますか？")) {
		return
	}
	var t = true;
	if (tf) {
		t = false;
	}
	for (var i in FriendList) {
		if (FriendList[i].state == t) {
			FriendList[i].state = tf;
		}
	}
	CheckFriendUnSave(true);
	putFriendLists();
}

function PutFriendName(fid, name) {
	var id = fid.replace("fname-", "");
	if (name.length < 1 || name == "") {
		FriendList[id].name = DefaultName;
		$("f-" + id).innerHTML = '<input type="text" class="nntext" id="fname-' + id + '" maxlength="11" size="22" onchange="PutFriendName(this.id,this.value)" />';
		$("f-" + id).className = "friend-name noname";
	} else {
		var n = name.replace(/\,/g, "");
		FriendList[id].name = n;
		$("f-" + id).innerHTML = n;
		$("f-" + id).className = "friend-name";
		$("f-" + id).ondblclick = function() {
			ShowNameForm(this.id, true)
		};
	}
	CheckFriendUnSave(true);
}

function ShowNameForm(fid, tf) {
	var id = fid.replace(/f-|fname-/, "");
	var name = FriendList[id].name;
	if (tf) {
		$("f-" + id).innerHTML = '<input type="text" class="nntext" id="fname-' + id + '" maxlength="11" size="22" onchange="PutFriendName(this.id,this.value)" onfocusout="ShowNameForm(this.id,false)" />';
		$("f-" + id).className = "friend-name noname";
	} else {
		$("f-" + id).innerHTML = name;
		$("f-" + id).className = "friend-name";
	}
	if (tf) {
		$('fname-' + id).focus();
		$('fname-' + id).value = name;
	}
}
var listT = '<li class="f-title"><span class="friend-id" style="text-align:center;">ID</span><span class="friend-name">名前</span><span class="friend-job">職業</span></li>';
var noList = '<li class="no-friend">登録中の友達がありません。</li>';
var noDelList = '<li class="no-friend">停止中の友達がありません。</li>';

function putFriendLists() {
	var friend = "";
	var delfriend = "";
	for (var i in FriendList) {
		var id = FriendList[i].id;
		var name = FriendList[i].name;
		var job = FriendList[i].job;
		var state = FriendList[i].state;
		var formswitch = "";
		var nclass = "";
		if (name == DefaultName) {
			name = '<input type="text" class="nntext" id="fname-' + id + '" maxlength="11" size="22" onchange="PutFriendName(this.id,this.value)" />';
			nclass = "noname";
		} else {
			formswitch = 'ondblclick="ShowNameForm(this.id,true)"';
		}
		if (id > 100000) {
			job = PlayerList[job];
		} else {
			job = HomList(job);
		}
		if (state) {
			friend += '<li><span class="friend-id"><span class="friend-switch-f" onclick="SwitchFriend(' + id + ',false);" title="停止中にする"></span>' + id + '</span><span class="friend-name ' + nclass + '" id="f-' + id + '" ' + formswitch + ' >' + name + '</span><span class="friend-job">' + job + '</span></li>';
		} else {
			delfriend += '<li><span class="friend-id"><span class="friend-switch-t" onclick="SwitchFriend(' + id + ',true);" title="登録中にする"></span>' + id + '</span><span class="friend-name ' + nclass + '" id="f-' + id + '" ' + formswitch + ' >' + name + '</span><span class="friend-job">' + job + '</span></li>';
		}
	}
	if (friend.length < 1) {
		friend = noList;
	} else {
		friend += '<li class="friend-sw-all"><img src="' + image["cancel"] + '" width="16" height="16" onclick="SwitchFriendAll(false)" />すべて停止中にする</li>';
	}
	if (delfriend.length < 1) {
		delfriend = noDelList;
	} else {
		delfriend += '<li class="friend-sw-all"><img src="' + image["smile"] + '" width="16" height="16" onclick="SwitchFriendAll(true)" />すべて登録中にする</li>';
	}
	friend = listT + friend;
	delfriend = listT + delfriend;
	$('now-friend').innerHTML = friend;
	$('deled-friend').innerHTML = delfriend;
}

function printFriendList() {
	var fl = ["", ""];
	var list = FriendList;
	for (var i in list) {
		var id = list[i].id;
		var name = list[i].name;
		var job = list[i].job;
		var state = list[i].state;
		if (state) {
			if (id > 100000) {
				fl[0] += "FriendList[" + id + "]=" + job + strCRLF;
			} else {
				fl[0] += "HomFriendList[" + id + "]=" + job + strCRLF;
			}
		}
		if (name != DefaultName) {
			fl[1] += id + "," + name + "," + job + strCRLF;
		}
	}
	return fl;
}

function CheckFriendUnSave(tf) {
	FriendUnSaved = tf;
	if (FriendUnSaved) {
		$('friend-save').style.color = "#000";
	} else {
		$('friend-save').style.color = "#CCC";
	}
}

function SaveFriend(ret) {
	if (FriendUnSaved) {
		var str = printFriendList();
		if (!confirm("Friend.luaに設定変更内容を保存します。\nよろしいですか？\n\n※名前を付けていない停止中の友達は、\nリストから完全に削除されます。")) {
			return
		}
		var pass = RO_Dir + "Friend.lua";
		var objFSO = new ActiveXObject("Scripting.FileSystemObject");
		try {
			var objFriFile = objFSO.OpenTextFile(pass, ForWriting, true);
		} catch (e) {
			alert("Friend.luaは他のプログラムによって使用されいるためセーブできません。\nセーブするには他のプログラムを終了してください。");
			return
		}
		objFriFile.Write(str[0]);
		objFriFile.Close();
		if (str[1].length > 1) {
			pass = RO_Dir + "FriendName.ini";
			objFriFile = objFSO.OpenTextFile(pass, ForWriting, true);
			objFriFile.Write(str[1]);
			objFriFile.Close();
		}
		CheckFriendUnSave(false);
		if (ret) {
			return str;
		} else {
			alert("保存しました。");
		}
		ReloadFriend();
	}
}
var FriendLoaded = 0;

function LoadFriend() {
	var pass = RO_Dir + "Friend.lua";
	var objFSO = new ActiveXObject("Scripting.FileSystemObject");
	if (!objFSO.FileExists(pass)) {
		$('friend-alert').style.display = "block";
		$('friend-alert').innerHTML = 'ディレクトリにFriend.luaがありません。';
		putFriendLists();
		CheckFriendUnSave(false);
		return
	} else {
		$('friend-alert').style.display = "none";
	}
	var objSetFile = objFSO.OpenTextFile(pass, ForReading);
	try {
		do {
			var str = objSetFile.ReadLine();
			var fdata = str.split("\]=");
			fdata[0] = fdata[0].replace(/FriendList\[|HomFriendList\[/g, "");
			if (!FriendList[fdata[0]] && fdata[0]) {
				FriendList[fdata[0]] = new FriendClass(fdata[0], fdata[1], true);
			}
		} while (objSetFile.AtEndOfStream == false);
	} catch (e) {
		var err = e;
	}
	objSetFile.close();
	CheckFriendUnSave(false);
	pass = RO_Dir + "FriendName.ini";
	if (objFSO.FileExists(pass)) {
		objSetFile = objFSO.OpenTextFile(pass, ForReading);
		try {
			do {
				var str = objSetFile.ReadLine();
				var fdata = str.split(",");
				if (!FriendList[fdata[0]] && fdata[0]) {
					FriendList[fdata[0]] = new FriendClass(fdata[0], fdata[2], false);
				}
				FriendList[fdata[0]].name = fdata[1];
			} while (objSetFile.AtEndOfStream == false);
		} catch (e) {
			var err = e;
		}
	}
	FriendLoaded = 1;
	putFriendLists();
}

function ReloadFriend(file) {
	if (FriendUnSaved) {
		if (!confirm("編集内容が保存されていません。\n再読込してもよろしいですか？")) {
			return
		}
	}
	FriendUnSaved = false;
	FriendList = [];
	LoadFriend();
}
var cocco_session = "";
var cocco_id = "";

function coccoAuth() {
	var uid = $('user_id').value;
	var upass = $('user_pass').value;
	if (uid.length < 1 || upass.length < 1) {
		coccoAlert("IDとパスワードを入力してください。");
		return
	}
	var url = cocco_bk_url + "auth/";
	var data = "id=" + uid + "&pass=" + upass;
	var authrequest = createhttprequest();
	authrequest.open("POST", url, true);
	authrequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
	authrequest.onreadystatechange = function() {
		if (authrequest.readyState == 4 && authrequest.status == 200) {
			var ret = authrequest.responseText;
			if (ret.match(/^true.*/)) {
				$('set-upload').onclick = function() {
					DataUpload('Set.lua')
				};
				$('mob-upload').onclick = function() {
					DataUpload('Mob.lua')
				};
				$('set-download').onclick = function() {
					DataDownload('Set.lua')
				};
				$('mob-download').onclick = function() {
					DataDownload('Mob.lua')
				};
				$('set-upload').style.color = "#000";
				$('mob-upload').style.color = "#000";
				$('set-download').style.color = "#000";
				$('mob-download').style.color = "#000";
				$('auth-form').innerHTML = '<img src="' + image["yes"] + '" width="16" height="16" class="mini-icon" />' + " ID : " + uid + "でログイン中　";
				$('auth-form').style.color = "#080";
				$('auth-form').style.fontWeight = "700";
				cocco_id = uid;
				cocco_session = ret.replace(/^true\,/, "");
			} else {
				coccoAlert("認証に失敗しました。<br />" + ret);
				$('auth-loading').innerHTML = "";
			}
		} else {}
	};
	authrequest.send(data);
	$('auth-loading').innerHTML = '<img src="' + image["loading"] + '" class="loading-icon" />';
}

function DataUpload(name) {
	var filename = name;
	if (LoadFlag == 0) {
		return
	}
	if (filename.match(/Mob.lua/)) {
		if (MobLoaded == 1) {
			filename = MobFileName;
		} else {
			coccoAlert("Mob.luaファイルがロードされていません。<br />Mob設定エディタで一旦ファイルをロードしてください。<br /><br />※この機能は、編集中のファイルをアップロードします。");
			return
		}
	} else {
		if (SetLoaded == 0) {
			coccoAlert("Set.luaが作成されていません。<br /><br />ファイルを一度作成してからアップロード出来るようになります。");
			return
		}
	}
	var add_alert = "";
	if (unSaved || MobUnSaved) {
		add_alert = "\n\n※保存していないデータは反映されません。\nセーブしてからアップロードすることをお奨めします。"
	}
	if (confirm(filename + "をアップロードします。" + add_alert)) {
		var updata = "";
		var pass = RO_Dir + filename;
		if (filename.match(/Mob.lua/)) {
			pass = MobFilePass;
		}
		var objFSO = new ActiveXObject("Scripting.FileSystemObject");
		if (!objFSO.FileExists(pass)) {
			coccoAlert("アップロード用のファイルがありません。");
			return
		}
		var objSetFile = objFSO.OpenTextFile(pass, ForReading);
		do {
			updata += objSetFile.ReadLine() + strCRLF;
		} while (objSetFile.AtEndOfStream == false);
		var url = cocco_bk_url + "up.php";
		var data = "id=" + cocco_id + "&ses=" + cocco_session + "&data=" + updata + "&name=" + filename;
		var uprequest = createhttprequest();
		uprequest.open("POST", url, true);
		uprequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		uprequest.onreadystatechange = function() {
			if (uprequest.readyState == 4 && uprequest.status == 200) {
				var ret = uprequest.responseText;
				if (ret.match(/^true.*/)) {
					coccoAlert("アップロード完了しました。");
				} else {
					coccoAlert("アップロードに失敗しました。<br />" + ret);
				}
			} else {}
		};
		uprequest.send(data);
	}
}

function DataDownload(name) {
	var filename = name;
	if (LoadFlag == 0) {
		return
	}
	if (filename.match(/Mob.lua/)) {
		if (MobLoaded == 1) {
			filename = MobFileName;
		} else {
			coccoAlert("Mob.luaファイルがロードされていません。<br />Mob設定エディタで一旦ファイルをロードしてください。<br /><br />※この機能は、編集中のファイルにバックアップデータを適用します。");
			return
		}
	} else {}
	var add_alert = "";
	if (unSaved || MobUnSaved) {
		add_alert = "\n\n※変更されている項目があります。\nダウンロードすると上書きされますがよろしいですか？"
	}
	if (confirm(filename + "をダウンロードします。" + add_alert)) {
		var url = cocco_bk_url + "dl.php";
		var data = "id=" + cocco_id + "&ses=" + cocco_session + "&name=" + filename;
		var dlrequest = createhttprequest();
		dlrequest.open("POST", url, true);
		dlrequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		dlrequest.onreadystatechange = function() {
			if (dlrequest.readyState == 4 && dlrequest.status == 200) {
				var ret = dlrequest.responseText;
				if (ret.match(/^true.*/)) {
					var add_res = "";
					if (filename.match(/Set.lua/)) {
						add_res = "「設定エディタ」タブを開き、Set.luaを保存してください。";
					} else {
						add_res = "「Mob設定エディタ」タブを開き、" + filename + "を保存してください。";
					}
					coccoAlert("ダウンロード完了しました。<br /><br />" + filename + "の内容をエディタに反映しました。<br />" + add_res + "<br />保存しない場合、設定が反映されません。");
					var fdata = ret.replace(/true\,/, "");
					if (filename.match(/Mob\.lua/)) {
						LoadMob(fdata);
					} else {
						ReloadSet(fdata);
					}
				} else {
					var fmsg = ret.split(",");
					coccoAlert("ダウンロードに失敗しました。<br />" + fmsg[1]);
				}
			} else {}
		};
		dlrequest.send(data);
	}
}

function CheckIDPASS() {
	var idpass = RO_Dir + "cocco_id.txt";
	var objFSO = new ActiveXObject("Scripting.FileSystemObject");
	if (objFSO.FileExists(idpass)) {
		var objFile = objFSO.OpenTextFile(idpass, ForReading, false);
		if (!objFile.AtEndOfStream) {
			var str = objFile.ReadLine();
			$('user_id').value = str;
			if (!objFile.AtEndOfStream) {
				str = objFile.ReadLine();
				$('user_pass').value = str;
			}
		}
	}
}
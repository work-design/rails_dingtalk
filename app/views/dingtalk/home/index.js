import * as dd from 'dingtalk-jsapi'

alert('dddd')
dd.ready(() => {
  dd.runtime.permission.requestAuthCode({
    corpId: 'ding9f5ed2cec249700e35c2f4657eb6378f',
    onSuccess(info) {
      const div = document.getElementById('dingding')
      div.innerText = info.code
      console.log(info)
      alert(info.code)
    }
  })

  dd.device.notification.alert({
    message: "测试",
    title: "提示",//可传空
    buttonName: "收到",
    onSuccess : function() {
      //onSuccess将在点击button之后回调
      /*回调*/
    },
    onFail : function(err) {}
  })

})

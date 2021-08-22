import * as dd from 'dingtalk-jsapi'

dd.ready(() => {
  dd.runtime.permission.requestAuthCode({
    corpId: 'ding9f5ed2cec249700e35c2f4657eb6378f',
    onSuccess(info) {
      const div = document.getElementById('dingding')
      div.innerText = info.code
      console.log(info)
      alert(info.code)
      fetch(ele.href, {
        method: method,
        headers: {
          Accept: 'text/vnd.turbo-stream.html'
        }
      }).then(response => {
        return response.text()
      }).then(body => {
        Turbo.renderStreamMessage(body)
      })
    },
    onFail(res) {
      alert('dd error: ' + JSON.stringify(res))
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

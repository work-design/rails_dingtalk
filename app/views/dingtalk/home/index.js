import * as dd from 'dingtalk-jsapi'
const div = document.getElementById('dingding')
div.innerText = 'sssss'
dd.ready(() => {
  dd.runtime.permission.requestAuthCode({
    corpId: 'ding9f5ed2cec249700e35c2f4657eb6378f',
    onSuccess(info) {
      div.innerText = info.code
      dd.device.notification.alert({
        message: JSON.stringify(info),
        buttonName: "收到"
      })
      fetch('https://soa-okr.tallty.com/dingtalk/apps/info', {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          corp_id: 'ding9f5ed2cec249700e35c2f4657eb6378f',
          code: info.code
        })
      }).then(response => {
        return response.text()
      }).then(body => {
        Turbo.renderStreamMessage(body)
      })
    },
    onFail(res) {
      div.innerText = JSON.stringify(res)
      dd.device.notification.alert({
        message: JSON.stringify(res),
        buttonName: "报错"
      })
    }
  })
  dd.device.notification.alert({
    message: '测试',
    buttonName: "收到"
  })
})

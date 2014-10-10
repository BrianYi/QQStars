import QQItemInfo 1.0
import QtQuick 2.2

FriendInfo{
    userQQ: myqq.userQQ
    function getQQFinished(error, data){//获取好友真实qq后调用的函数
        if(error){
            myqq.getFriendQQ( uin, getQQFinished )//获取好友的真实qq号
            return
        }
        
        data = JSON.parse(data)
        if( data.retcode==0 ){
            account = data.result.account
            console.log(nick+"的真实qq号是："+account+","+uin+","+alias)
            getAvatar(40)
        }
    }
    function getAvatarFinished( path ,name){
        var imageName = path+"/"+name+".png"
        avatar40 = imageName//保存自己头像的地址
    }
    function getQQSignatureFinished(error, data){//获取个性签名完成
        if(error){
            myqq.getQQSignature( uin, getQQSignatureFinished )//获取个性签名
            return
        }
        
        data = JSON.parse(data)
        if( data.retcode==0 ){
            QQSignature = data.result[0].lnick//储存个性签名
        }
    }
    onQQSignatureChanged: {
        if( QQSignature=="" ){
            myqq.getQQSignature( uin, getQQSignatureFinished )//获取个性签名
        }
    }
    function getAvatar(size){
        if(account!=""){
            if( avatar40=="qrc:/images/avatar.png" ){
                myqq.downloadImage("http://q.qlogo.cn/headimg_dl?spec="+String(size)+"&dst_uin="+account, "friend_"+uin, String(size), getAvatarFinished)//下载头像
            }
        }else{
            myqq.getFriendQQ( uin, getQQFinished )//获取好友的真实qq号
        }
    }

    onAccountChanged: {
        getAvatar(40)
    }
    
    onAvatar40Changed: {
        if( avatar40=="qrc:/images/avatar.png" )
            getAvatar(40)
    }
}

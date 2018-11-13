KindEditor.ready(function(K) {
                K.create('textarea[name=content]',{
                    width:'800px',
                    height:'200px',
                    //配置上传地址，这个地址在url.py中已经配置好了，要和它对应
                    uploadJson: '/admin/upload/kindeditor',
                });
        });
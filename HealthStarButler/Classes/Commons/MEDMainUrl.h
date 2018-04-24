//
//  MEDMainUrl.h
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/13.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

//需要引用的借口文档地址

#ifndef MEDThyroid_MEDMainUrl_h
#define MEDThyroid_MEDMainUrl_h

//------------ @@@@@  ------------
//测试环境
//http://10.1.1.19/
#define MED_DOMAIN_REQUEST @"http://10.1.1.19/app/"
#define MED_EASYMOBE_REQUEST @"http://10.1.1.19/app/"
#define MED_BASE_REQUEST  @"http://10.1.1.19/"
#define MED_WEBSOCKET_Service @"ws://10.1.1.19/app/"
#define MED_CHAT_REQUEST @"http://10.1.1.19" //聊天查看图片专用

//正式环境
//#define MED_DOMAIN_REQUEST @"http://api.mmednet.com/app/"
//#define MED_EASYMOBE_REQUEST @"http://api.mmednet.com/app/"
//#define MED_BASE_REQUEST  @"http://api.mmednet.com/"
//#define MED_WEBSOCKET_Service @"ws://api.mmednet.com/app/"
////#define MED_CHAT_REQUEST @"http://api.mmednet.com" //聊天图片
//#define MED_CHAT_REQUEST @"http://res.mmednet.com" //聊天图片

//演示环境
//#define MED_DOMAIN_REQUEST @"http://gz.service.mmednet.com/app/"
//#define MED_EASYMOBE_REQUEST @"http://gz.service.mmednet.com/app/"
//#define MED_BASE_REQUEST  @"http://gz.service.mmednet.com/"
//#define MED_WEBSOCKET_Service @"ws://gz.service.mmednet.com/app/"
//#define MED_CHAT_REQUEST @"http://res.test.mmednet.com" //聊天查看图片专用

//someone本地
//#define MED_DOMAIN_REQUEST @"http://10.1.2.153:8080/app/"
//#define MED_EASYMOBE_REQUEST @"http://10.1.2.153:8080/app/"
//#define MED_BASE_REQUEST  @"http://10.1.2.153:8080/"
//#define MED_WEBSOCKET_Service @"ws://10.1.2.153:8080/app/"
//#define MED_CHAT_REQUEST @"http://10.1.2.153:8080" //聊天查看图片专用


/*
 2017-08-19 
 为了方便对接口网关做统一限流的处理  在统一的请求方法中增加参数 ： appversion apiversion apiplatform
 具体操作在网络工具类MEDDataRequest中
 app端统一接口网关 ： http://api.mmednet.com
 appversion 统一取当前移动客户端的版本号 如1.8.0
 apiversion的值暂定为 v1
 apiplatform : 健康管家为 health  机器人为 robot
 */

//老版本平台URL - 除资讯与导诊还在使用，大部分暂时不再使用
//正式平台  @"http://miot.mmednet.com/p/"
//测试平台  @"http://218.241.151.250/p/"

//------------ ##待确认后删除##  ------------
//新正式平台(暂时不会用到)
//http://miot2.mmednet.com/app
//#define MED_DOMAIN_REQUEST @"http://miot2.mmednet.com/app/"
//#define MED_EASYMOBE_REQUEST @"http://miot2.mmednet.com/app/"
//#define MED_WEBSOCKET_Service @"ws://miot2.mmednet.com/app/"
//#define MED_CHAT_REQUEST @"http://miot2.mmednet.com" //聊天查看图片专用

//正式平台
//#define MED_DOMAIN_REQUEST @"http://miot.mmednet.com/shark/p/"
//#define MED_IMAGE_HEADER @"http://miot.mmednet.com"
//#define MED_EASYMOBE_REQUEST @"http://miot.mmednet.com/shark/p/"
//#define MED_WEBSOCKET_Service @"ws://miot.mmednet.com/shark/p"

//测试平台
//#define MED_DOMAIN_REQUEST @"http://218.241.151.250/shark/p/"
//#define MED_IMAGE_HEADER  @"http://218.241.151.250"
//#define MED_EASYMOBE_REQUEST @"http://218.241.151.250/shark/p/"
//#define MED_WEBSOCKET_Service   @"ws://218.241.151.250/shark/p"

//------------ ##待确认后删除##  ------------


#pragma mark -------------------- 登录 --------------------
//ZMZFIX
//登陆
//http://miot.mmednet.com/p/user/login?telephoneNumber=admin&password=112233
#define MED_USER_LOGIN      @"user/login"
#define TELEPHONE_NUMBER    @"telephone_number"
#define PASSWORD            @"password"

//忘记密码
#define FORGET_PASSWORD     @"user/reset_pwd"
#define FORGET_TELEPHONE    @"telphone"
#define FORGET_NEWPASSWORD  @"newpassword"

//登录获取验证码
#define Reset_Code @"user/reset_code"
#define Reset_TELEPHONE   @"telphone"

//体检报告获取验证码
//http://miot.mmednet.com/p/user/reset_code
#define FORGET_PASSWORD_CODE @"user/verification_code?"
#define FORGET_TELEPHONE     @"telphone"
//uid=58

//验证验证码
//http://miot.mmednet.com/p/user/reset_validation
#define FORGET_DO_CODE      @"user/reset_validation"
#define FORGET_CODE         @"code"

//重置密码http://miot.mmednet.com/p/user/update/password
#define RESET_PASSWORD      @"user/update/password"
#define NEW_PASSWORD        @"new_password"


#pragma mark -------------------- 首页 --------------------
//ZMZFIX
#pragma mark 弹窗判断
//问卷弹窗
#define MED_Questionnaire_home  @"health/question/questionFillInStatus"

#pragma mark 健康资讯
//首页新闻
#define MED_Channel_home        @"channel/index"

#pragma mark 山东分数相关

#define MED_HomeScoreExplain   @"health/personalIndexRanking/list"

#define MED_HomeScoreRankingList @"health/personalstatistics/async/getAppPIRList"

#define MED_PersonalScoreRank  @"health/personalstatistics/async/getPerasonRanking"

#pragma mark 健康监测
//血压提交
#define MED_bloodpressure_ADD   @"health/bloodpressure/add"
//血压查询
#define MED_bloodpressure_LIST  @"health/bloodpressure/list"

//血糖提交
#define MED_bloodglucose_ADD    @"health/bloodglucose/add"
//血糖查询
#define MED_bloodglucose_LIST   @"health/bloodglucose/list"

//血氧提交
#define MED_bloodoximete_ADD    @"health/bloodoximete/add"
//血氧查询
#define MED_bloodoximete_LIST   @"health/bloodoximete/list"

//体重提交
#define MED_weight_ADD          @"health/weight/add"
//体重查询
#define MED_weight_LIST         @"health/weight/list"

#define MED_temperature_ADD    @"health/temperature/add"

#define MED_temperature_LIST    @"health/temperature/list"
//腰围提交
#define MED_waist_ADD           @"health/waist/add"
//腰围查询
#define MED_waist_LIST          @"health/waist/list"

//运动提交3.历史-获取一个时间段数据
#define MED_pedometer_ADD
//运动查询
#define MED_pedometer_LIST      @"health/pedometer/list"

//获取单日运动计划
#define MED_sportPlan_List      @"health/sportlog/listone"
//提交单日运动计划
#define MED_sportPlan_submit    @"health/sportlog/submit"

//-添加运动数据-
#define MED_sportPlan_Add    @"health/sportlog/add"

//—运动列表查询—
#define MED_sportPlan_list    @"health/sportlog/list"


//睡眠提交
#define MED_sleep_ADD
//睡眠查询
#define MED_sleep_LIST          @"health/sleep/list"

#define MED_activity_List      @"health/sportlog/list"


#pragma mark - 管理

#pragma mark -------------------- 健康方案 --------------------

//方案个人信息标签
#define MED_USER_INFO @"user/getUserBasicInfo"
//ZMZFIX
//最新方案  http://miot2.mmednet.com/app/health/scheme/listlastone?
#define MED_NEW_PROJECT @"health/scheme/listlastone?"

//所有方案  http://miot2.mmednet.com/app/health/scheme/schemelist?
#define MED_ALL_PROJECT @"health/scheme/schemelist?"

//某一个方案 http://miot2.mmednet.com/apphealth/scheme/schemeinfo?"
#define MED_ONE_PROJECT @"health/scheme/schemeinfo?"
#define ONE_ID  @"id"

//用药方案反馈
#define MED_MedicineUseFeedback @"hypertensionQuestionnaire/intoDrugsFeekback?"
#define MED_MedicineUseFeedbackSuccess @"question/ajax/success"


#pragma mark -------------------- 随访问卷 --------------------
//ZMZFIX
//随访问卷列表
#define followup_Questionnaire_List @"hypertensionQuestionnaire/findQuestionnaireFA"
//随访问卷填写
#define followup_Questionnaire_fill @"web/hypertensionQuestionnaire/questionnaireFA"
//随访问卷成功
#define followup_Success @"health/question/ajax/success"

#pragma mark -------------------- 疾病问卷 --------------------
//ZMZFIX
//查询是否有疾病问卷
#define diseaseQuestionnaire_Whether @"hypertensionQuestionnaire/diseaseQuestionnaireNum"
//这里使用的userId不是uid
//疾病问卷入口
#define hypertension_Questionnaire_Entry @"web/hypertensionQuestionnaire/diseaseQuestionnaireEntry"
//跳转依据
#define diseaseQuestionnaire_jump  @"ajax/success"
//用上面值做跳转判断这两个暂时不用，暂时保留
//疾病问卷成功，弹窗点击确定
#define diseaseQuestionnaire_Success  @"ajax/successDiseaseAssessment"
//一般人成功,弹窗点击知道了点取消都是这个提示
#define diseaseQuestionnaire_Normoal_Success @"ajax/success"

#pragma mark -------------------- 健康小结(新) --------------------
#define MED_Summary @"health/summary/show"

#pragma mark -------------------- 体检报告 --------------------
//ZMZFIX
//体检报告-获取验证码
#define MEDPhysicalGetVerification_code  @"user/verification_code?"

//绑定体检报告(手机绑定体检报告)
#define MEDPhysical_ExaminationGetRecord   @"physicalExamination/record"

//体检报告列表
#define MEDQUERYRECORDLIST          @"physicalExamination/queryRecordList"

//报告详情-总检报告
#define MEDPhysical_GetPhysicalExaminationSuggest_Report @"physicalExamination/getPhysicalExaminationSuggest"

//报告详情-报告详情
#define MEDPhysical_queryPhysicalExaminationInfo     @"physicalExamination/queryPhysicalExaminationInfo2"

//报告详情-异常分析
#define MEDPhysical_queryAbnormalPhysicalExaminationInfo     @"physicalExamination/queryAbnormalPhysicalExaminationInfo"

//体检报告对比-获得异常指标
#define MEDPhysical_queryPhysicalIndexConctrast     @"physicalExamination/queryPhysicalIndexConctrast"

#pragma mark - 资讯
//ZMZFIX
#pragma mark -------------------- 健康资讯 --------------------

//首页新闻 - 首页处
//#define MED_Channel_home        @"channel/index"

//http://10.1.1.19/app/channel/list
//资讯频道列表（title）
#define MED_Channel_list     @"channel/list"

//
#define MED_News_List        @"news/list?"

//新闻资讯详情
#define MED_NEWS_details     @"news/details"

#pragma mark - 导诊
//ZMZFIX
#pragma mark -------------------- 智能导诊 --------------------

//智能导诊信息
#define MED_INTELLECT   @"robot/p/intelligent/submit?"
#define USER_ID         @"uid"
#define S_ID            @"sid"

//智能导诊咨询
#define MED_DEPARTMENT  @"robot/p/intelligent/diseases?"
#define DID             @"did"

//智能导诊疾病临床症状
#define MED_SYMPTOM     @"robot/p/intelligent/clinlcalsymptom?"
#define DISEASE_ID      @"diseaseId"

#pragma mark - 个人中心
//ZMZFIX
#pragma mark -------------------- 个人中心 --------------------
//获取用户基础信息
//http://10.1.1.19/app/user/getUserInfo
#define MED_GET_USERINFO        @"user/getUserInfo"

// 修改用户基础信息
//http://10.1.1.19/app/user/update
#define MED_UPDATE_USERINFO     @"user/update"

// 上传头像
////user/upload/icon
#define MED_Update_icon         @"user/upload/icon"

//我的设备获取
//http://miot.mmednet.com/app/user/device
#define MY_DEVICE_GET           @"user/device"

//我的设备上传
//http://miot.mmednet.com/app/user/update/device
#define MY_DEVICE               @"user/update/device"
#define DEVICE_ID               @"deviceid"

//发送用户反馈
#define MED_FEEDBACK            @"user/feedback"


//最新小结http://miot.mmednet.com/p/health/summary/latest
#define MED_NEW_SUMMARY @"health/summary/latest?"

//所有小结http://miot.mmednet.com/p/health/summary/list
#define MED_ALL_SUMMARY @"health/summary/list"
#define PAPGE_NUM   @"pn"//1
#define LIST_NUM    @"ps"//500


//++++++++++最新院后随访http://miot.mmednet.com/p/guide/listlastone
#define MED_NEW_VISIT   @"health/followup_hospi/listlastone?"

//++++++院后随访记录http://miot.mmednet.com/p/guide/guideList
#define MED_ALL_VISIT   @"health/followup_hospi/guideList?"

//++++++++某一个院后随访http://miot.mmednet.com/p/guide/guideInfo
#define MED_ONE_VISIT   @"app/health/followup_hospi/guideInfo?"


//某一个小结http://miot.mmednet.com/p/health/summary/get?
#define MED_ONE_SUMMARY @"health/summary/get"
#define ONE_INFO    @"intervene_summary_id"//500


////智能导诊信息
//#define MED_INTELLECT   @"intelligent/submit?"
//#define USER_ID     @"uid"
//#define S_ID        @"sid"
//
////智能导诊咨询
//#define MED_DEPARTMENT  @"intelligent/diseases?"
//#define DID         @"did"
//
////智能导诊疾病临床症状
//#define MED_SYMPTOM @"intelligent/clinlcalsymptom?"
//#define DISEASE_ID   @"diseaseId"


//++++++查询评估详情
#define MEDChectAssessmentReprot @"health/assessment/viewAssessReport"

//+++++查询评估报告列表
#define MEDGetAssessmentReportList  @"health/assessment/queryAssessReportList"


//++++新增诊疗记录
#define MEDAddDiagnosisTreatRecord   @"medical/addDiagnosisTreatRecord"

//+++++++更新诊疗记录
#define MEDUpdateDiagnosisTreatRecord  @"medical/updateDiagnosisTreatRecord"

//++++++新增诊疗记录数据
//#define MEDViewDiagnosisTreatRecord     @"medical/addDiagnosisTreatRecord"
//+++++诊疗记录列表
#define  MEDQueryDiagnosisTreat         @"medical/queryDiagnosisTreatRecord"


//++++++新增检测报告
#define  MEDAddDetectionReport          @"medical/addDetectionReport"

//+++++++根据ID查看检测报告
#define  MEDViewDetectionReport   @"medical/viewDetectionReport"
//+++++++分页查询检测报告
#define MEDQueryDetectionReport     @"medical/queryDetectionReport"
//+++++++上传报告文件
#define MEDTestReportUploadReportFile     @"medical/uploadReportFile"

//++++++删除报告文件
#define MEDTestReportDelegateFile       @"medical/delFile"
//+++++++更新报告文件/
#define MEDUpdateDetectionReport    @"medical/updateDetectionReport"



//获取最新动态问卷和最新基础问卷
#define MEDGetLatestTrendsQuestionnair  @"health/question/getDynamicQuestionnaire"


//提交基础问卷(动态问卷233，基础问卷232)
#define MEDQuestionDynamicubmit  @"health/question/submitDynamicQuesitonnaire"

//++++++获取健康调查问卷
#define MEDQuestion  @"health/question/healthQuestionnaire"
//++++++健康问卷成功跳转
#define MEDQUESTIONSUCCESS @"health/question/ajax/success"
//+++++健康调查问卷历史问卷
#define  MEDQuestionHistory @"health/question/history"


/*****************/
//++++++中医体质问卷
#define CHINAQUESTION @"health/question/tcmQuestionnaire"
//++++++中医体质问卷成功后跳转
#define CHINASUCCESS @"health/question/ajax/success"
//+++++++中医历史问卷列表
#define CHINALIST @"health/tcmAssessment/queryTcmAssessmentList"
//+++++++中医体质辨识
#define  MED_NEW_CHINESE_DOC    @"health/tcmAssessment/findTcmAssessment"



//+++++提交饮食日志
//http://miot.mmednet.com/p/foodlog/base/submit
#define MEDCOMMIT_FOODDATE  @"health/foodlog/base/submit"

//++++查看饮食日志结果
//http://miot.mmednet.com/p/foodlog/base/listone  请求提交过得数据
#define MEDFOODDATE_RESULT  @"health/foodlog/base/listone"


//++++++查看历史饮食日志
//http://miot.mmednet.com/p/foodlog/base/listFoodLogData    某一个月的icon表示（日历）
#define MEDHISTORY_FOODDATE @"health/foodlog/base/listDateInterval?"

//+++++++++查看历史饮食日志反馈
//http://miot.mmednet.com/p/foodlog/base/listFoodLogEneger  得出结果页面计算公式
#define MED_FOODDATE_RETURN @"health/foodlog/base/listFoodLogEneger"


//首页新闻详情
//http://miot.mmednet.com/p/news/index
#define MED_FIRST_NEWS  @"news/index"



//保存医患互动聊天记录到本地服务器
#define HealthSaveMessageToLocalServer  @"easemob/save_message"

//根据环信用户名获取本地用户信息
#define MEDEasemob_access_username   @"easemob/access_username"

#define  MEDConsultChatInfoDetail  @"im/chat/info" //医生详信息



/***********************************************************聊天--会话*/
#define Get_Friends           @"im/user/getfriends"  //获取好友
#define Get_Groups            @"im/user/getgroups"  //获取群组

#define Websocket_Userid      @"websocket/im/1/"  //发送信息
#define UploadChat_Image      @"im/upload"  //聊天发送图片


#endif

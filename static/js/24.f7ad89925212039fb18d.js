webpackJsonp([24,45,47,48],{10:function(e,t,n){"use strict";function a(e){return e&&e.__esModule?e:{default:e}}Object.defineProperty(t,"__esModule",{value:!0});var r=n(5),o=a(r),i=n(4);t.default={name:"empty-bg",props:{msg:""},components:{},created:function(){},methods:{},computed:(0,o.default)({},(0,i.mapState)(["path","userid"]))}},11:function(e,t,n){t=e.exports=n(1)(),t.push([e.id,".empty-bg[data-v-05ffcd02]{height:85%;width:100%;display:-ms-flexbox;display:flex;-ms-flex-align:center;align-items:center;text-align:center}.empty-bg .emptybg-container[data-v-05ffcd02]{width:100%}.empty-bg .emptybg-container .img[data-v-05ffcd02]{max-width:40%;height:auto}.empty-bg .emptybg-container .tips[data-v-05ffcd02]{font-size:.13rem;margin-top:.1rem;color:#424242;letter-spacing:.005rem}","",{version:3,sources:["/./src/components/popupBox/emptyBg.vue"],names:[],mappings:"AACA,2BACE,WAAY,AACZ,WAAY,AAGZ,oBAAqB,AACrB,aAAc,AAGV,sBAAuB,AACnB,mBAAoB,AAC5B,iBAAmB,CACpB,AACD,8CACE,UAAY,CACb,AACD,mDACE,cAAe,AACf,WAAa,CACd,AACD,oDACE,iBAAmB,AACnB,iBAAmB,AACnB,cAAe,AACf,sBAAyB,CAC1B",file:"emptyBg.vue",sourcesContent:["\n.empty-bg[data-v-05ffcd02] {\n  height: 85%;\n  width: 100%;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n  text-align: center;\n}\n.empty-bg .emptybg-container[data-v-05ffcd02] {\n  width: 100%;\n}\n.empty-bg .emptybg-container .img[data-v-05ffcd02] {\n  max-width: 40%;\n  height: auto;\n}\n.empty-bg .emptybg-container .tips[data-v-05ffcd02] {\n  font-size: 0.13rem;\n  margin-top: 0.1rem;\n  color: #424242;\n  letter-spacing: 0.005rem;\n}"],sourceRoot:"webpack://"}])},12:function(e,t,n){var a=n(11);"string"==typeof a&&(a=[[e.id,a,""]]);n(2)(a,{});a.locals&&(e.exports=a.locals)},13:function(e,t,n){e.exports=n.p+"static/img/logo.d513bde.png"},14:function(e,t,n){n(12);var a=n(3)(n(10),n(15),"data-v-05ffcd02",null);e.exports=a.exports},15:function(e,t,n){e.exports={render:function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"empty-bg"},[a("div",{staticClass:"emptybg-container"},[a("img",{staticClass:"img",attrs:{onclick:"return false",src:n(13)}}),e._v(" "),a("p",{staticClass:"tips"},[e._v(e._s(this.msg))])])])},staticRenderFns:[]}},125:function(e,t,n){"use strict";function a(e){return e&&e.__esModule?e:{default:e}}Object.defineProperty(t,"__esModule",{value:!0});var r=n(5),o=a(r),i=n(4);t.default={name:"order-cell",data:function(){return{}},props:{cellData:{type:Object,default:function(){return{id:"",time:"",username:"",userTel:"",state:"",goodsname:"",price:0}}}},components:{},activated:function(){},mounted:function(){},computed:(0,o.default)({},(0,i.mapState)(["openid","path","role"])),methods:{markToProcessed:function(){this.$parent&&this.$parent.$parent&&this.$parent.$parent.markToProcessed(this.cellData)}}}},137:function(e,t,n){t=e.exports=n(1)(),t.push([e.id,'.order-cell[data-v-6ed9b5d6]{padding:0 .1rem}.order-cell .header[data-v-6ed9b5d6]{display:-ms-flexbox;display:flex;-ms-flex-align:center;align-items:center;-ms-flex-pack:justify;justify-content:space-between;height:.26rem;color:#303030}.order-cell .header .icon-riliriqi[data-v-6ed9b5d6]{font-size:.16rem}.order-cell .header .icon-riliriqi .time[data-v-6ed9b5d6]{margin-left:.05rem;font-size:.12rem;font-weight:600}.order-cell .header .order-no[data-v-6ed9b5d6]{font-size:.12rem;letter-spacing:.01rem}.order-cell .content[data-v-6ed9b5d6]{min-height:.48rem;display:-ms-flexbox;display:flex;-ms-flex-direction:column;flex-direction:column;-ms-flex-pack:center;justify-content:center}.order-cell .content .info[data-v-6ed9b5d6]{font-size:.13rem;color:#303030}.order-cell .content .info .info-title[data-v-6ed9b5d6]{letter-spacing:.01rem}.order-cell .content .info.user-info .icon-phone[data-v-6ed9b5d6]{font-size:.14rem;color:#fd8709}.order-cell .content .info.user-info .extra[data-v-6ed9b5d6]{color:#fd8709}.order-cell .content .info.goods-info[data-v-6ed9b5d6]{margin-top:.05rem}.order-cell .content .info.goods-info .extra[data-v-6ed9b5d6]{color:#fd8709}.order-cell .state[data-v-6ed9b5d6]{position:relative;height:.3rem;display:-ms-flexbox;display:flex;-ms-flex-align:center;align-items:center;-ms-flex-pack:end;justify-content:flex-end;font-size:.12rem;letter-spacing:.01rem}.order-cell .state[data-v-6ed9b5d6]:after{display:block;position:absolute;left:0;top:0;border-top:1px solid #e3e3e3;width:100%;content:""}.order-cell .state .click-item[data-v-6ed9b5d6]{color:#303030;padding:.02rem .05rem;border-radius:.03rem;border:1px solid #999}.order-cell .state .tip[data-v-6ed9b5d6]{color:#707070;font-size:.12rem;padding-right:.03rem}',"",{version:3,sources:["/./src/components/megoods/agency/order/orderCell.vue"],names:[],mappings:"AACA,6BACE,eAAkB,CACnB,AACD,qCAGE,oBAAqB,AACrB,aAAc,AAGV,sBAAuB,AACnB,mBAAoB,AAGxB,sBAAuB,AACnB,8BAA+B,AACvC,cAAgB,AAChB,aAAe,CAChB,AACD,oDACE,gBAAmB,CACpB,AACD,0DACE,mBAAqB,AACrB,iBAAmB,AACnB,eAAiB,CAClB,AACD,+CACE,iBAAmB,AACnB,qBAAwB,CACzB,AACD,sCACE,kBAAoB,AAGpB,oBAAqB,AACrB,aAAc,AAIV,0BAA2B,AACvB,sBAAuB,AAG3B,qBAAsB,AAClB,sBAAwB,CACjC,AACD,4CACE,iBAAmB,AACnB,aAAe,CAChB,AACD,wDACE,qBAAwB,CACzB,AACD,kEACE,iBAAmB,AACnB,aAAe,CAChB,AACD,6DACE,aAAe,CAChB,AACD,uDACE,iBAAoB,CACrB,AACD,8DACE,aAAe,CAChB,AACD,oCACE,kBAAmB,AACnB,aAAe,AAGf,oBAAqB,AACrB,aAAc,AAGV,sBAAuB,AACnB,mBAAoB,AAGxB,kBAAmB,AACf,yBAA0B,AAClC,iBAAmB,AACnB,qBAAwB,CACzB,AACD,0CACE,cAAe,AACf,kBAAmB,AACnB,OAAQ,AACR,MAAO,AACP,6BAA8B,AAC9B,WAAY,AACZ,UAAY,CACb,AACD,gDACE,cAAe,AACf,sBAAyB,AACzB,qBAAuB,AACvB,qBAAuB,CACxB,AACD,yCACE,cAAe,AACf,iBAAmB,AACnB,oBAAuB,CACxB",file:"orderCell.vue",sourcesContent:["\n.order-cell[data-v-6ed9b5d6] {\n  padding: 0 0.1rem;\n}\n.order-cell .header[data-v-6ed9b5d6] {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n  -webkit-box-pack: justify;\n  -webkit-justify-content: space-between;\n      -ms-flex-pack: justify;\n          justify-content: space-between;\n  height: 0.26rem;\n  color: #303030;\n}\n.order-cell .header .icon-riliriqi[data-v-6ed9b5d6] {\n  font-size: 0.16rem;\n}\n.order-cell .header .icon-riliriqi .time[data-v-6ed9b5d6] {\n  margin-left: 0.05rem;\n  font-size: 0.12rem;\n  font-weight: 600;\n}\n.order-cell .header .order-no[data-v-6ed9b5d6] {\n  font-size: 0.12rem;\n  letter-spacing: 0.01rem;\n}\n.order-cell .content[data-v-6ed9b5d6] {\n  min-height: 0.48rem;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  -webkit-box-pack: center;\n  -webkit-justify-content: center;\n      -ms-flex-pack: center;\n          justify-content: center;\n}\n.order-cell .content .info[data-v-6ed9b5d6] {\n  font-size: 0.13rem;\n  color: #303030;\n}\n.order-cell .content .info .info-title[data-v-6ed9b5d6] {\n  letter-spacing: 0.01rem;\n}\n.order-cell .content .info.user-info .icon-phone[data-v-6ed9b5d6] {\n  font-size: 0.14rem;\n  color: #fd8709;\n}\n.order-cell .content .info.user-info .extra[data-v-6ed9b5d6] {\n  color: #fd8709;\n}\n.order-cell .content .info.goods-info[data-v-6ed9b5d6] {\n  margin-top: 0.05rem;\n}\n.order-cell .content .info.goods-info .extra[data-v-6ed9b5d6] {\n  color: #fd8709;\n}\n.order-cell .state[data-v-6ed9b5d6] {\n  position: relative;\n  height: 0.3rem;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n  -webkit-box-pack: end;\n  -webkit-justify-content: flex-end;\n      -ms-flex-pack: end;\n          justify-content: flex-end;\n  font-size: 0.12rem;\n  letter-spacing: 0.01rem;\n}\n.order-cell .state[data-v-6ed9b5d6]:after {\n  display: block;\n  position: absolute;\n  left: 0;\n  top: 0;\n  border-top: 1px solid #e3e3e3;\n  width: 100%;\n  content: '';\n}\n.order-cell .state .click-item[data-v-6ed9b5d6] {\n  color: #303030;\n  padding: 0.02rem 0.05rem;\n  border-radius: 0.03rem;\n  border: 1px #999 solid;\n}\n.order-cell .state .tip[data-v-6ed9b5d6] {\n  color: #707070;\n  font-size: 0.12rem;\n  padding-right: 0.03rem;\n}"],sourceRoot:"webpack://"}])},142:function(e,t,n){var a=n(137);"string"==typeof a&&(a=[[e.id,a,""]]);n(2)(a,{});a.locals&&(e.exports=a.locals)},146:function(e,t,n){n(142);var a=n(3)(n(125),n(151),"data-v-6ed9b5d6",null);e.exports=a.exports},151:function(e,t){e.exports={render:function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"order-cell"},[n("div",{staticClass:"header"},[n("span",{staticClass:"iconfont icon-riliriqi"},[n("span",{staticClass:"time"},[e._v(e._s(e.cellData.time))])]),e._v(" "),n("span",{staticClass:"order-no"},[e._v("编号："+e._s(e.cellData.id))])]),e._v(" "),n("div",{staticClass:"content"},[n("div",{staticClass:"info user-info"},[n("span",{staticClass:"info-title"},[e._v("(商家)：")]),e._v(" "),n("span",{staticClass:"name"},[e._v(e._s(e.cellData.username)+" ")]),e._v(",\n            "),n("a",{attrs:{href:"tel:"+e.cellData.userTel}},[n("span",{staticClass:"iconfont icon-phone"}),n("span",{staticClass:"extra"},[e._v(e._s(e.cellData.userTel))])])]),e._v(" "),n("div",{staticClass:"info goods-info"},[n("span",{staticClass:"info-title"},[e._v("(商品)：")]),e._v(" "),n("span",{staticClass:"name"},[e._v(e._s(e.cellData.goodsname)+" ")]),e._v(",\n            "),n("span",{staticClass:"extra"},[e._v("¥"+e._s(e.cellData.price))])])]),e._v(" "),n("div",{staticClass:"state"},["0"==e.cellData.state.toString()?n("span",{staticClass:"click-item",on:{click:e.markToProcessed}},[e._v("标记为已处理")]):"3"==e.cellData.state.toString()?n("span",{staticClass:"tip"},[e._v("退款中")]):"4"==e.cellData.state.toString()?n("span",{staticClass:"tip"},[e._v("已退款")]):"5"==e.cellData.state.toString()?n("span",{staticClass:"tip"},[e._v("已处理")]):e._e()])])},staticRenderFns:[]}},208:function(e,t,n){"use strict";function a(e){return e&&e.__esModule?e:{default:e}}Object.defineProperty(t,"__esModule",{value:!0});var r=n(5),o=a(r),i=n(4),s=n(56),l=n(14),d=a(l),c=n(146),A=a(c),p=n(6),f=a(p),m=n(7);f.default.use(m.InfiniteScroll),t.default={name:"processed-order",data:function(){return{goodsArr:null,showEmpty:!1,emptyMsg:"没有已处理的订单~",memoryScroll:0,isLoadDb:!1,cellLoading:!0,curPage:0,pageNum:10,existIdArr:[]}},components:{EmptyBg:d.default,orderCell:A.default},mounted:function(){this.showEmpty=!1,this.$parent&&(this.$parent.processedData=[],this.goodsArr=this.$parent.processedData),this.requestData(!1)},activated:function(){this.$refs.scrollContent&&(this.$refs.scrollContent.scrollTop=this.memoryScroll),this.isLoadDb&&this.$store.dispatch("toggleLoading",!1)},beforeRouteLeave:function(e,t,n){this.memoryScroll=this.$refs.scrollContent.scrollTop,n()},methods:{requestData:function(){var e=this,t=!(arguments.length>0&&void 0!==arguments[0])||arguments[0];t&&0==this.page||t&&this.cellLoading||(this.cellLoading=!0,this.$http.post(this.path+"php/Route.php",{type:"agentgoods",aid:this.userid,page:this.curPage,tp:1}).then(function(t){e.$store.dispatch("toggleLoading",!1),e.isLoadDb=!0;var n=t.body.arr;if(n&&0!=n.length){n.length%10==0?(e.curPage++,e.cellLoading=!1):e.cellLoading=!0;for(var a=e.analysisData(n),r=0;r<a.length;r++){var o=a[r].id;e.existIdArr.indexOf(o)>=0||(e.goodsArr.push(a[r]),e.existIdArr.push(o))}}else e.cellLoading=!0,0==e.curPage&&(e.showEmpty=!0)}))},analysisData:function(e){var t=[];return e.forEach(function(e,n,a){var r=new Date(1e3*e.buytime),o=(0,s.formatDate)(r,"yyyy-MM-dd hh:mm");t.push({id:e.buyid,username:e.username,userTel:e.phone,time:o,goodsname:e.gname,price:e.price,state:e.orderstate})}),t}},computed:(0,o.default)({},(0,i.mapState)(["path","userid","role"]))}},296:function(e,t,n){t=e.exports=n(1)(),t.push([e.id,".processed-order[data-v-15d4f2ec]{height:100%}.processed-order .cell[data-v-15d4f2ec]{box-sizing:border-box;margin:0 .06rem;border-radius:.02rem;background:#fff;margin-bottom:.08rem}","",{version:3,sources:["/./src/components/megoods/agency/order/processedOrder.vue"],names:[],mappings:"AACA,kCACE,WAAa,CACd,AACD,wCACE,sBAAuB,AACvB,gBAAkB,AAClB,qBAAuB,AACvB,gBAAiB,AACjB,oBAAuB,CACxB",file:"processedOrder.vue",sourcesContent:["\n.processed-order[data-v-15d4f2ec] {\n  height: 100%;\n}\n.processed-order .cell[data-v-15d4f2ec] {\n  box-sizing: border-box;\n  margin: 0 0.06rem;\n  border-radius: 0.02rem;\n  background: #fff;\n  margin-bottom: 0.08rem;\n}"],sourceRoot:"webpack://"}])},358:function(e,t,n){var a=n(296);"string"==typeof a&&(a=[[e.id,a,""]]);n(2)(a,{});a.locals&&(e.exports=a.locals)},436:function(e,t,n){n(358);var a=n(3)(n(208),n(488),"data-v-15d4f2ec",null);e.exports=a.exports},488:function(e,t){e.exports={render:function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{ref:"scrollContent",staticClass:"processed-order"},[n("ul",{directives:[{name:"infinite-scroll",rawName:"v-infinite-scroll",value:e.requestData,expression:"requestData"}],staticClass:"cell-content",attrs:{"infinite-scroll-disabled":"cellLoading","infinite-scroll-distance":"0","infinite-scroll-immediate-check":"false"}},e._l(e.goodsArr,function(e){return n("li",[n("order-cell",{staticClass:"cell",attrs:{"cell-data":e}})],1)})),e._v(" "),n("empty-bg",{directives:[{name:"show",rawName:"v-show",value:e.showEmpty,expression:"showEmpty"}],attrs:{msg:e.emptyMsg}})],1)},staticRenderFns:[]}}});
//# sourceMappingURL=24.f7ad89925212039fb18d.js.map
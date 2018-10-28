webpackJsonp([36],{

/***/ 184:
/***/ (function(module, exports, __webpack_require__) {

var Component = __webpack_require__(80)(
  /* script */
  __webpack_require__(257),
  /* template */
  __webpack_require__(620),
  /* scopeId */
  null,
  /* cssModules */
  null
)

module.exports = Component.exports


/***/ }),

/***/ 257:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* harmony default export */ __webpack_exports__["default"] = ({
    data: function data() {
        return {
            form: {
                name: '',
                region: '',
                date1: '',
                date2: '',
                delivery: true,
                type: ['步步高'],
                resource: '小天才',
                desc: ''
            }
        };
    },
    methods: {
        onSubmit: function onSubmit() {
            this.$message.success('提交成功！');
        }
    }
});

/***/ }),

/***/ 620:
/***/ (function(module, exports) {

module.exports={render:function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', [_c('div', {
    staticClass: "crumbs"
  }, [_c('el-breadcrumb', {
    attrs: {
      "separator": "/"
    }
  }, [_c('el-breadcrumb-item', [_c('i', {
    staticClass: "el-icon-date"
  }), _vm._v(" 表单")]), _vm._v(" "), _c('el-breadcrumb-item', [_vm._v("基本表单")])], 1)], 1), _vm._v(" "), _c('div', {
    staticClass: "form-box"
  }, [_c('el-form', {
    ref: "form",
    attrs: {
      "model": _vm.form,
      "label-width": "80px"
    }
  }, [_c('el-form-item', {
    attrs: {
      "label": "表单名称"
    }
  }, [_c('el-input', {
    model: {
      value: (_vm.form.name),
      callback: function($$v) {
        _vm.$set(_vm.form, "name", $$v)
      },
      expression: "form.name"
    }
  })], 1), _vm._v(" "), _c('el-form-item', {
    attrs: {
      "label": "选择器"
    }
  }, [_c('el-select', {
    attrs: {
      "placeholder": "请选择"
    },
    model: {
      value: (_vm.form.region),
      callback: function($$v) {
        _vm.$set(_vm.form, "region", $$v)
      },
      expression: "form.region"
    }
  }, [_c('el-option', {
    key: "bbk",
    attrs: {
      "label": "步步高",
      "value": "bbk"
    }
  }), _vm._v(" "), _c('el-option', {
    key: "xtc",
    attrs: {
      "label": "小天才",
      "value": "xtc"
    }
  }), _vm._v(" "), _c('el-option', {
    key: "imoo",
    attrs: {
      "label": "imoo",
      "value": "imoo"
    }
  })], 1)], 1), _vm._v(" "), _c('el-form-item', {
    attrs: {
      "label": "日期时间"
    }
  }, [_c('el-col', {
    attrs: {
      "span": 11
    }
  }, [_c('el-date-picker', {
    staticStyle: {
      "width": "100%"
    },
    attrs: {
      "type": "date",
      "placeholder": "选择日期"
    },
    model: {
      value: (_vm.form.date1),
      callback: function($$v) {
        _vm.$set(_vm.form, "date1", $$v)
      },
      expression: "form.date1"
    }
  })], 1), _vm._v(" "), _c('el-col', {
    staticClass: "line",
    attrs: {
      "span": 2
    }
  }, [_vm._v("-")]), _vm._v(" "), _c('el-col', {
    attrs: {
      "span": 11
    }
  }, [_c('el-time-picker', {
    staticStyle: {
      "width": "100%"
    },
    attrs: {
      "type": "fixed-time",
      "placeholder": "选择时间"
    },
    model: {
      value: (_vm.form.date2),
      callback: function($$v) {
        _vm.$set(_vm.form, "date2", $$v)
      },
      expression: "form.date2"
    }
  })], 1)], 1), _vm._v(" "), _c('el-form-item', {
    attrs: {
      "label": "选择开关"
    }
  }, [_c('el-switch', {
    attrs: {
      "on-text": "",
      "off-text": ""
    },
    model: {
      value: (_vm.form.delivery),
      callback: function($$v) {
        _vm.$set(_vm.form, "delivery", $$v)
      },
      expression: "form.delivery"
    }
  })], 1), _vm._v(" "), _c('el-form-item', {
    attrs: {
      "label": "多选框"
    }
  }, [_c('el-checkbox-group', {
    model: {
      value: (_vm.form.type),
      callback: function($$v) {
        _vm.$set(_vm.form, "type", $$v)
      },
      expression: "form.type"
    }
  }, [_c('el-checkbox', {
    attrs: {
      "label": "步步高",
      "name": "type"
    }
  }), _vm._v(" "), _c('el-checkbox', {
    attrs: {
      "label": "小天才",
      "name": "type"
    }
  }), _vm._v(" "), _c('el-checkbox', {
    attrs: {
      "label": "imoo",
      "name": "type"
    }
  })], 1)], 1), _vm._v(" "), _c('el-form-item', {
    attrs: {
      "label": "单选框"
    }
  }, [_c('el-radio-group', {
    model: {
      value: (_vm.form.resource),
      callback: function($$v) {
        _vm.$set(_vm.form, "resource", $$v)
      },
      expression: "form.resource"
    }
  }, [_c('el-radio', {
    attrs: {
      "label": "步步高"
    }
  }), _vm._v(" "), _c('el-radio', {
    attrs: {
      "label": "小天才"
    }
  }), _vm._v(" "), _c('el-radio', {
    attrs: {
      "label": "imoo"
    }
  })], 1)], 1), _vm._v(" "), _c('el-form-item', {
    attrs: {
      "label": "文本框"
    }
  }, [_c('el-input', {
    attrs: {
      "type": "textarea"
    },
    model: {
      value: (_vm.form.desc),
      callback: function($$v) {
        _vm.$set(_vm.form, "desc", $$v)
      },
      expression: "form.desc"
    }
  })], 1), _vm._v(" "), _c('el-form-item', [_c('el-button', {
    attrs: {
      "type": "primary"
    },
    on: {
      "click": _vm.onSubmit
    }
  }, [_vm._v("提交")]), _vm._v(" "), _c('el-button', [_vm._v("取消")])], 1)], 1)], 1)])
},staticRenderFns: []}

/***/ })

});
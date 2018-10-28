webpackJsonp([3],{

/***/ 190:
/***/ (function(module, exports, __webpack_require__) {


/* styles */
__webpack_require__(649)

var Component = __webpack_require__(80)(
  /* script */
  __webpack_require__(263),
  /* template */
  __webpack_require__(606),
  /* scopeId */
  "data-v-10c5ad18",
  /* cssModules */
  null
)

module.exports = Component.exports


/***/ }),

/***/ 224:
/***/ (function(module, exports) {

/*
	MIT License http://www.opensource.org/licenses/mit-license.php
	Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
module.exports = function(useSourceMap) {
	var list = [];

	// return the list of modules as css string
	list.toString = function toString() {
		return this.map((function (item) {
			var content = cssWithMappingToString(item, useSourceMap);
			if(item[2]) {
				return "@media " + item[2] + "{" + content + "}";
			} else {
				return content;
			}
		})).join("");
	};

	// import a list of modules into the list
	list.i = function(modules, mediaQuery) {
		if(typeof modules === "string")
			modules = [[null, modules, ""]];
		var alreadyImportedModules = {};
		for(var i = 0; i < this.length; i++) {
			var id = this[i][0];
			if(typeof id === "number")
				alreadyImportedModules[id] = true;
		}
		for(i = 0; i < modules.length; i++) {
			var item = modules[i];
			// skip already imported module
			// this implementation is not 100% perfect for weird media query combinations
			//  when a module is imported multiple times with different media queries.
			//  I hope this will never occur (Hey this way we have smaller bundles)
			if(typeof item[0] !== "number" || !alreadyImportedModules[item[0]]) {
				if(mediaQuery && !item[2]) {
					item[2] = mediaQuery;
				} else if(mediaQuery) {
					item[2] = "(" + item[2] + ") and (" + mediaQuery + ")";
				}
				list.push(item);
			}
		}
	};
	return list;
};

function cssWithMappingToString(item, useSourceMap) {
	var content = item[1] || '';
	var cssMapping = item[3];
	if (!cssMapping) {
		return content;
	}

	if (useSourceMap && typeof btoa === 'function') {
		var sourceMapping = toComment(cssMapping);
		var sourceURLs = cssMapping.sources.map((function (source) {
			return '/*# sourceURL=' + cssMapping.sourceRoot + source + ' */'
		}));

		return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
	}

	return [content].join('\n');
}

// Adapted from convert-source-map (MIT)
function toComment(sourceMap) {
	// eslint-disable-next-line no-undef
	var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap))));
	var data = 'sourceMappingURL=data:application/json;charset=utf-8;base64,' + base64;

	return '/*# ' + data + ' */';
}


/***/ }),

/***/ 225:
/***/ (function(module, exports, __webpack_require__) {

/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Author Tobias Koppers @sokra
  Modified by Evan You @yyx990803
*/

var hasDocument = typeof document !== 'undefined'

if (typeof DEBUG !== 'undefined' && DEBUG) {
  if (!hasDocument) {
    throw new Error(
    'vue-style-loader cannot be used in a non-browser environment. ' +
    "Use { target: 'node' } in your Webpack config to indicate a server-rendering environment."
  ) }
}

var listToStyles = __webpack_require__(226)

/*
type StyleObject = {
  id: number;
  parts: Array<StyleObjectPart>
}

type StyleObjectPart = {
  css: string;
  media: string;
  sourceMap: ?string
}
*/

var stylesInDom = {/*
  [id: number]: {
    id: number,
    refs: number,
    parts: Array<(obj?: StyleObjectPart) => void>
  }
*/}

var head = hasDocument && (document.head || document.getElementsByTagName('head')[0])
var singletonElement = null
var singletonCounter = 0
var isProduction = false
var noop = function () {}

// Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
// tags it will allow on a page
var isOldIE = typeof navigator !== 'undefined' && /msie [6-9]\b/.test(navigator.userAgent.toLowerCase())

module.exports = function (parentId, list, _isProduction) {
  isProduction = _isProduction

  var styles = listToStyles(parentId, list)
  addStylesToDom(styles)

  return function update (newList) {
    var mayRemove = []
    for (var i = 0; i < styles.length; i++) {
      var item = styles[i]
      var domStyle = stylesInDom[item.id]
      domStyle.refs--
      mayRemove.push(domStyle)
    }
    if (newList) {
      styles = listToStyles(parentId, newList)
      addStylesToDom(styles)
    } else {
      styles = []
    }
    for (var i = 0; i < mayRemove.length; i++) {
      var domStyle = mayRemove[i]
      if (domStyle.refs === 0) {
        for (var j = 0; j < domStyle.parts.length; j++) {
          domStyle.parts[j]()
        }
        delete stylesInDom[domStyle.id]
      }
    }
  }
}

function addStylesToDom (styles /* Array<StyleObject> */) {
  for (var i = 0; i < styles.length; i++) {
    var item = styles[i]
    var domStyle = stylesInDom[item.id]
    if (domStyle) {
      domStyle.refs++
      for (var j = 0; j < domStyle.parts.length; j++) {
        domStyle.parts[j](item.parts[j])
      }
      for (; j < item.parts.length; j++) {
        domStyle.parts.push(addStyle(item.parts[j]))
      }
      if (domStyle.parts.length > item.parts.length) {
        domStyle.parts.length = item.parts.length
      }
    } else {
      var parts = []
      for (var j = 0; j < item.parts.length; j++) {
        parts.push(addStyle(item.parts[j]))
      }
      stylesInDom[item.id] = { id: item.id, refs: 1, parts: parts }
    }
  }
}

function createStyleElement () {
  var styleElement = document.createElement('style')
  styleElement.type = 'text/css'
  head.appendChild(styleElement)
  return styleElement
}

function addStyle (obj /* StyleObjectPart */) {
  var update, remove
  var styleElement = document.querySelector('style[data-vue-ssr-id~="' + obj.id + '"]')

  if (styleElement) {
    if (isProduction) {
      // has SSR styles and in production mode.
      // simply do nothing.
      return noop
    } else {
      // has SSR styles but in dev mode.
      // for some reason Chrome can't handle source map in server-rendered
      // style tags - source maps in <style> only works if the style tag is
      // created and inserted dynamically. So we remove the server rendered
      // styles and inject new ones.
      styleElement.parentNode.removeChild(styleElement)
    }
  }

  if (isOldIE) {
    // use singleton mode for IE9.
    var styleIndex = singletonCounter++
    styleElement = singletonElement || (singletonElement = createStyleElement())
    update = applyToSingletonTag.bind(null, styleElement, styleIndex, false)
    remove = applyToSingletonTag.bind(null, styleElement, styleIndex, true)
  } else {
    // use multi-style-tag mode in all other cases
    styleElement = createStyleElement()
    update = applyToTag.bind(null, styleElement)
    remove = function () {
      styleElement.parentNode.removeChild(styleElement)
    }
  }

  update(obj)

  return function updateStyle (newObj /* StyleObjectPart */) {
    if (newObj) {
      if (newObj.css === obj.css &&
          newObj.media === obj.media &&
          newObj.sourceMap === obj.sourceMap) {
        return
      }
      update(obj = newObj)
    } else {
      remove()
    }
  }
}

var replaceText = (function () {
  var textStore = []

  return function (index, replacement) {
    textStore[index] = replacement
    return textStore.filter(Boolean).join('\n')
  }
})()

function applyToSingletonTag (styleElement, index, remove, obj) {
  var css = remove ? '' : obj.css

  if (styleElement.styleSheet) {
    styleElement.styleSheet.cssText = replaceText(index, css)
  } else {
    var cssNode = document.createTextNode(css)
    var childNodes = styleElement.childNodes
    if (childNodes[index]) styleElement.removeChild(childNodes[index])
    if (childNodes.length) {
      styleElement.insertBefore(cssNode, childNodes[index])
    } else {
      styleElement.appendChild(cssNode)
    }
  }
}

function applyToTag (styleElement, obj) {
  var css = obj.css
  var media = obj.media
  var sourceMap = obj.sourceMap

  if (media) {
    styleElement.setAttribute('media', media)
  }

  if (sourceMap) {
    // https://developer.chrome.com/devtools/docs/javascript-debugging
    // this makes source maps inside style tags work properly in Chrome
    css += '\n/*# sourceURL=' + sourceMap.sources[0] + ' */'
    // http://stackoverflow.com/a/26603875
    css += '\n/*# sourceMappingURL=data:application/json;base64,' + btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))) + ' */'
  }

  if (styleElement.styleSheet) {
    styleElement.styleSheet.cssText = css
  } else {
    while (styleElement.firstChild) {
      styleElement.removeChild(styleElement.firstChild)
    }
    styleElement.appendChild(document.createTextNode(css))
  }
}


/***/ }),

/***/ 226:
/***/ (function(module, exports) {

/**
 * Translates the list format produced by css-loader into something
 * easier to manipulate.
 */
module.exports = function listToStyles (parentId, list) {
  var styles = []
  var newStyles = {}
  for (var i = 0; i < list.length; i++) {
    var item = list[i]
    var id = item[0]
    var css = item[1]
    var media = item[2]
    var sourceMap = item[3]
    var part = {
      id: parentId + ':' + i,
      css: css,
      media: media,
      sourceMap: sourceMap
    }
    if (!newStyles[id]) {
      styles.push(newStyles[id] = { id: id, parts: [part] })
    } else {
      newStyles[id].parts.push(part)
    }
  }
  return styles
}


/***/ }),

/***/ 244:
/***/ (function(module, exports) {

module.exports = {
  isMobile: /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent),

  setCssText(obj) {
    let cssArr = [];
    for(let key in obj) {
      let val = obj[key];
      if (typeof val === 'number') {
        val = '' + val + 'px';
      }
      cssArr.push(`${key}:${val};`)
    }
    return cssArr.join('');
  }
};


/***/ }),

/***/ 249:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
const GIF_LOADING_SRC = 'data:image/gif;base64,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';

/* harmony default export */ __webpack_exports__["default"] = (GIF_LOADING_SRC);


/***/ }),

/***/ 250:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _drag2 = __webpack_require__(589);

var _drag3 = _interopRequireDefault(_drag2);

var _resize2 = __webpack_require__(590);

var _resize3 = _interopRequireDefault(_resize2);

var _loadingGif = __webpack_require__(249);

var _loadingGif2 = _interopRequireDefault(_loadingGif);

var _helper = __webpack_require__(244);

var _helper2 = _interopRequireDefault(_helper);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// set cropbox size in image
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

var CROPBOX_PERCENT = 75;
exports.default = {
  props: {
    formId: {
      type: String,
      default: ''
    },
    ratio: {
      type: String,
      default: '1:1'
    }
  },

  data: function data() {
    return {
      src: _loadingGif2.default,
      width: 24,
      height: 24,
      cropCSS: {}
    };
  },


  methods: {
    setImage: function setImage(src, w, h) {
      this.src = src;
      if (this.ratio.indexOf(':') > 0) {
        this.ratioW = this.ratio.split(':')[0];
        this.ratioH = this.ratio.split(':')[1];
        this.ratioVal = this.ratioW / this.ratioH;
      } else {
        this.ratioW = 1;
        this.ratioH = 1;
        this.ratioVal = this.ratio;
      }
      this.setLayout(w, h);
      this.setCropBox();
    },
    setLayout: function setLayout(w, h) {
      var H = window.innerHeight - 80,
          W = window.innerWidth - 60,
          width = w,
          height = h;
      // caculate the image ratio
      var R = width / height;
      var Rs = W / H;
      var $container = this.$el;
      if (R > Rs) {
        width = W;
        height = W / R;
        // I don't hope to use a state to change the container stye
        $container.style.cssText = 'width:' + W + 'px;height:' + W / R + 'px;margin-top:' + (H - W / R) / 2 + 'px';
      } else {
        width = H * R, height = H;
        $container.style.cssText = 'width:' + H * R + 'px;height:' + H + 'px;margin-left:' + (W - H * R) / 2 + 'px;';
      }
      this.imgChangeRatio = width / w;
      this.width = width;
      this.height = height;
    },
    setCropBox: function setCropBox() {
      var $selectCropBox = this.__find('.crop-box');
      var $wrap = this.$el;
      var imageWidth = this.width,
          imageHeight = this.height;
      var ratioW = this.ratioW,
          ratioH = this.ratioH;
      var baseCropWidth = imageWidth / 100 * CROPBOX_PERCENT;
      var CSSObj = {
        width: baseCropWidth,
        height: baseCropWidth / ratioW * ratioH
      };
      CSSObj.left = (imageWidth - baseCropWidth) / 2;
      CSSObj.top = (imageHeight - CSSObj.height) / 2;
      $selectCropBox.style.cssText = _helper2.default.setCssText(CSSObj);
      if (CSSObj.height > imageHeight) {
        var baseCropHeight = imageHeight / 100 * CROPBOX_PERCENT;
        CSSObj.height = baseCropHeight;
        CSSObj.width = CSSObj.height * ratioW / ratioH;
        CSSObj.left = (imageWidth - CSSObj.width) / 2, CSSObj.top = (imageHeight - CSSObj.height) / 2, $selectCropBox.style.cssText = _helper2.default.setCssText(CSSObj);
      };
      this.cropCSS = CSSObj;
    },
    getCropData: function getCropData() {
      // keep compatible with old api
      return {
        toCropImgX: this.cropCSS.left / this.imgChangeRatio,
        toCropImgY: this.cropCSS.top / this.imgChangeRatio,
        toCropImgW: this.cropCSS.width / this.imgChangeRatio,
        toCropImgH: this.cropCSS.height / this.imgChangeRatio
      };
    },
    getCropImage: function getCropImage() {
      return this.$refs['crop-image'];
    },
    __find: function __find(str) {
      var dq = document.querySelector('#vciu-modal-' + this.formId);
      return dq.querySelector(str);
    },

    // resize and drag move
    resize: function resize(e) {
      e.stopPropagation();
      var $el = e.target.parentElement;
      var $container = this.__find('.g-crop-image-principal');
      if (this._$container) {
        this._$container = container;
      }
      var self = this;
      var coor = {
        x: _helper2.default.isMobile ? e.touches[0].clientX : e.clientX,
        y: _helper2.default.isMobile ? e.touches[0].clientY : e.clientY,
        w: parseInt(window.getComputedStyle($el).width, 10),
        h: parseInt(window.getComputedStyle($el).height, 10)
      };
      this.el = $el;
      this.container = $container;
      var move = function move(ev) {
        var newCropStyle = (0, _resize3.default)(ev, self.el, $container, coor, self.ratioVal);
        if (newCropStyle) {
          self.cropCSS.width = newCropStyle.width;
          self.cropCSS.height = newCropStyle.height;
        }
      };
      var end = function end(ev) {
        this.el = null;
        if (_helper2.default.isMobile) {
          document.removeEventListener('touchmove', move, false);
          document.removeEventListener('touchend', end, false);
        }
        document.removeEventListener('mousemove', move, false);
        document.removeEventListener('mouseup', end, false);
      };

      if (_helper2.default.isMobile) {
        document.addEventListener('touchmove', move, false);
        document.addEventListener('touchend', end, false);
      }
      document.addEventListener('mousemove', move, false);
      document.addEventListener('mouseup', end, false);
    },
    drag: function drag(e) {
      e.preventDefault();
      var $el = e.target;
      this.el = $el;
      var $container = this.$el;
      var $infoAside = document.getElementsByClassName('image-aside')[0];
      var self = this;
      var isMobile = _helper2.default.isMobile;
      var coor = {
        x: (isMobile ? e.touches[0]['clientX'] : e.clientX) - $el.offsetLeft - $el.parentElement.offsetLeft - $infoAside.offsetLeft,
        y: (isMobile ? e.touches[0]['clientY'] : e.clientY) - $el.offsetTop - $el.parentElement.offsetTop - $infoAside.offsetTop,
        posX: isMobile ? e.touches[0]['clientX'] : e.clientX,
        posy: isMobile ? e.touches[0]['clientY'] : e.clientY,
        maxLeft: parseInt($container.style.width) - parseInt($el.style.width),
        maxTop: parseInt($container.style.height) - parseInt($el.style.height)
      };
      var move = function move(ev) {
        var newCropStyle = (0, _drag3.default)(ev, self.el, coor);
        if (newCropStyle) {
          self.cropCSS.left = newCropStyle.left;
          self.cropCSS.top = newCropStyle.top;
        }
      };
      var stopMove = function stopMove(ev) {
        self.el = null;
        if (isMobile) {
          document.removeEventListener('touchmove', move, false);
          document.removeEventListener('touchend', stopMove, false);
          return;
        }
        document.removeEventListener('mousemove', move, false);
        document.removeEventListener('mouseup', stopMove, false);
      };
      if (isMobile) {
        document.addEventListener('touchmove', move, false);
        document.addEventListener('touchend', stopMove, false);
        return;
      }
      document.addEventListener('mousemove', move, false);
      document.addEventListener('mouseup', stopMove, false);
    }
  }

};

/***/ }),

/***/ 251:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; //
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

var _xhr = __webpack_require__(591);

var _xhr2 = _interopRequireDefault(_xhr);

var _loadingGif = __webpack_require__(249);

var _loadingGif2 = _interopRequireDefault(_loadingGif);

var _canvasHelper = __webpack_require__(588);

var _canvasHelper2 = _interopRequireDefault(_canvasHelper);

var _props = __webpack_require__(592);

var _props2 = _interopRequireDefault(_props);

var _crop = __webpack_require__(594);

var _crop2 = _interopRequireDefault(_crop);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.default = {
  components: {
    Crop: _crop2.default
  },
  props: _props2.default,
  data: function data() {
    return {
      files: [],
      hasImage: false,
      options: this.props,
      uploading: false,
      formID: (Math.random() * 10000 + '').split('.')[0],
      image: {
        src: _loadingGif2.default,
        width: 24,
        height: 24
      }
    };
  },


  computed: {
    name: function name() {
      if (this.multiple) {
        return this.inputOfFile + '[]';
      }
      return this.inputOfFile;
    }
  },

  methods: {
    __dispatch: function __dispatch(name, res) {
      this.$emit && this.$emit(name, res);
    },
    __find: function __find(str) {
      var dq = document.querySelector('#vciu-modal-' + this.formID);
      return dq.querySelector(str);
    },
    change: function change(e) {
      var _this = this;

      var fileVal = document.querySelector('#g-core-upload-input-' + this.formID).value.replace(/C:\\fakepath\\/i, "");
      var fileExt = fileVal.substring(fileVal.lastIndexOf(".") + 1);
      var extensionsArr = this.extensions.split(',');
      if (extensionsArr.length > 1) {
        var reg = new RegExp('^[' + extensionsArr.join('|') + ']+$', 'i');
        if (!reg.test(fileExt)) {
          return this.__dispatch('errorhandle', 'TYPE ERROR');
        }
      }

      if (e.target.files[0].size > this.maxFileSize) {
        var formatSize;
        if (parseInt(this.maxFileSize / 1024 / 1024) > 0) {
          formatSize = (this.maxFileSize / 1024 / 1024).toFixed(2) + 'MB';
        } else if (parseInt(this.maxFileSize / 1024) > 0) {
          formatSize = (this.maxFileSize / 1024).toFixed(2) + 'kB';
        } else {
          formatSize = options.maxFileSize.toFixed(2) + 'Byte';
        }
        console.warn('FILE IS TOO LARGER MAX FILE IS ' + formatSize);
        return this.__dispatch('errorhandle', 'FILE IS TOO LARGER MAX FILE IS ' + formatSize);
      }

      this.files = e.target.files;

      if (this.crop) {
        this.__showImage();
        return;
      }
      this.__dispatch('imagechanged', this.files[0]);
      if (this.compress) {
        _canvasHelper2.default.compress(this.files[0], 100 - this.compress, (function (code) {
          _this.tryAjaxUpload('', true, code);
        }));
      } else {
        this.tryAjaxUpload();
      }
    },
    __showImage: function __showImage() {
      this.hasImage = true;
      this.__readFiles();
    },
    __readFiles: function __readFiles() {
      var reader = new FileReader();
      var self = this;
      reader.onload = function (e) {
        var src = e.target.result;
        self.__initImage(src);
      };
      reader.readAsDataURL(this.files[0]);
    },


    // set the image size
    __initImage: function __initImage(src) {
      var pic = new Image();
      var self = this;
      pic.src = src;
      var cropBox = this.$refs.cropBox;
      pic.onload = function () {
        self.imgChangeRatio = cropBox.setImage(src, pic.naturalWidth, pic.naturalHeight);
      };
    },
    doCrop: function doCrop(e) {
      var _this2 = this;

      var btn = e.target;
      btn.value = btn.value + '...';
      btn.disabled = true;
      if (_typeof(this.data) !== 'object') {
        this.data = {};
      }
      this.data["request"] = "crop";
      var cropBox = this.$refs.cropBox;
      var newCSSObj = cropBox.getCropData();

      var _iteratorNormalCompletion = true;
      var _didIteratorError = false;
      var _iteratorError = undefined;

      try {
        for (var _iterator = Object.keys(newCSSObj)[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
          var k = _step.value;

          this.data[k] = newCSSObj[k];
        }
      } catch (err) {
        _didIteratorError = true;
        _iteratorError = err;
      } finally {
        try {
          if (!_iteratorNormalCompletion && _iterator.return) {
            _iterator.return();
          }
        } finally {
          if (_didIteratorError) {
            throw _iteratorError;
          }
        }
      }

      if (this.maxWidth) {
        this.data['maxWidth'] = this.maxWidth;
      }
      if (this.maxHeight) {
        this.data['maxHeight'] = this.maxHeight;
      }
      var upload = function upload(code) {
        _this2.tryAjaxUpload((function () {
          btn.value = btn.value.replace('...', '');
          btn.disabled = false;
        }), code ? true : false, code);
      };
      if (this.crop === 'local') {
        var targetImage = cropBox.getCropImage();
        this.data.comprose = 100 - this.compress;
        return _canvasHelper2.default.crop(targetImage, this.data, (function (code) {
          upload(code);
        }));
      }
      upload();
    },
    cancel: function cancel() {
      this.hasImage = false;
      this.files = '';
      document.querySelector('#g-core-upload-input-' + this.formID).value = '';
    },


    // use ajax upload  IE9+
    tryAjaxUpload: function tryAjaxUpload(callback, isBinary, base64Code) {
      var self = this;
      this.__dispatch('imageuploading', this.files[0]);
      var done = function done(res) {
        if (typeof callback === 'function') {
          callback();
        }
        self.uploading = false;
        self.cancel();
        self.__dispatch('imageuploaded', res);
      };
      var errorUpload = function errorUpload(err) {
        self.__dispatch('errorhandle', err);
      };
      if (!this.isXhr) {
        if (this.crop) {
          this.hasImage = false;
        }
        return typeof callback === 'function' && callback();
      }
      var data = void 0;
      if (isBinary) {
        data = {
          type: this.files[0]['type'],
          filename: this.files[0]['name'],
          filed: this.inputOfFile,
          base64Code: base64Code
        };
      } else {
        data = new FormData();
        for (var i = 0; i < this.files.length; i++) {
          data.append(this.name, this.files[i]);
        }
        if (_typeof(this.data) === 'object') {
          for (var k in this.data) {
            if (this.data[k] !== undefined) {
              data.append(k, this.data[k]);
            }
          }
        }
      }
      (0, _xhr2.default)('POST', this.url, this.headers, data, done, errorUpload, isBinary);
    }
  }

};

/***/ }),

/***/ 263:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_vue_core_image_upload__ = __webpack_require__(587);
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
            src: '../../res/img/img.jpg',
            fileList: []
        };
    },
    components: {
        VueCoreImageUpload: __WEBPACK_IMPORTED_MODULE_0_vue_core_image_upload__["a" /* default */]
    },
    methods: {
        imageuploaded: function imageuploaded(res) {
            console.log(res);
        },
        handleRemove: function handleRemove(file, fileList) {
            console.log(file, fileList);
        },
        handlePreview: function handlePreview(file) {
            console.log(file);
        },
        handleError: function handleError() {
            this.$notify.error({
                title: '上传失败',
                message: '图片上传接口上传失败，可更改为自己的服务器接口'
            });
        }
    }
});

/***/ }),

/***/ 301:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(224)(false);
// imports


// module
exports.push([module.i, ".g-core-image-upload-btn{position:relative;overflow:hidden}.g-core-image-upload-form{position:absolute;left:0;right:0;top:0;bottom:0;opacity:0}.g-core-image-upload-container{position:absolute;background:#111;z-index:900}.g-core-image-upload-modal{position:absolute;left:0;right:0;width:100%;height:100%;border:1px solid #ccc;z-index:899}.dropped{border:4px solid #ea6153}.g-core-image-corp-container{z-index:1900;position:fixed;left:0;right:0;top:0;bottom:0;background:rgba(0,0,0,.9);color:#f1f1f1}.g-core-image-corp-container .image-aside{overflow:hidden;position:absolute;right:30px;left:30px;top:60px;bottom:20px;text-align:center}.g-core-image-corp-container .image-aside img{max-width:100%;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}.g-core-image-corp-container .info-aside{position:absolute;left:0;right:0;top:0;height:40px;padding-left:10px;padding-right:10px;background:#fefefe;color:#777}.g-core-image-corp-container .info-aside .image-corp-preview{position:relative;overflow:hidden;text-align:center;border:2px solid #ccc}.g-core-image-corp-container .info-aside .image-corp-preview.circled{border-radius:160px}.g-core-image-corp-container .info-aside .image-corp-preview img{width:100%}.g-core-image-corp-container .info-aside .config-info .image-details{width:100%;color:#999}.g-core-image-corp-container .info-aside .config-info .image-details td{border:none;line-height:24px}.g-core-image-corp-container .info-aside .config-info .image-details tr td:first-child{width:36%}.g-core-image-corp-container .info-aside .config-info .image-details tr td:last-child{color:#555}.g-core-image-corp-container .btn-groups{text-align:right;margin:5px 0 0}.g-core-image-corp-container .btn{display:inline-block;padding:0 15px;height:32px;margin-left:15px;background:#fff;border:1px solid #ccc;border-radius:2px;font-size:13px;color:#222;line-height:32px;transition:all .1s ease-in}.g-core-image-corp-container .btn:hover{border:1px solid #777;box-shadow:0 1px 3px rgba(0,0,0,.05)}.g-core-image-corp-container .btn:active{background:#ddd}.g-core-image-corp-container .btn:disabled{background:#eee!important;border-color:#ccc;cursor:not-allowed}.g-core-image-corp-container .btn-upload{background:#27ae60;border-color:#27ae60;color:#fff}.g-core-image-corp-container .btn-upload:hover{background:#2dc26c;border-color:#27ae60;box-shadow:0 1px 3px rgba(0,0,0,.05)}.g-core-image-corp-container .g-crop-image-box,.g-core-image-corp-container .g-crop-image-box .g-crop-image-principal{position:relative}", ""]);

// exports


/***/ }),

/***/ 303:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(224)(false);
// imports


// module
exports.push([module.i, ".content-title[data-v-10c5ad18]{font-weight:400;line-height:50px;margin:10px 0;font-size:22px;color:#1f2f3d}.pre-img[data-v-10c5ad18]{width:250px;height:250px;margin-bottom:20px}", ""]);

// exports


/***/ }),

/***/ 317:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(224)(false);
// imports


// module
exports.push([module.i, ".image-mask[data-v-885bff96]{position:absolute;left:0;top:0;width:100%;height:100%}.image-mask .mask[data-v-885bff96]{position:absolute;background-color:hsla(0,0%,100%,.6)}.crop-box[data-v-885bff96]{position:absolute;background:none;cursor:move;width:100px;height:100px;border:1px solid hsla(0,0%,100%,.95)}.crop-box[data-v-885bff96]:after,.crop-box[data-v-885bff96]:before{content:\"\";display:block;opacity:0;position:absolute;left:33.3333%;top:0;width:33.334%;height:100%;background-color:transparent;border:0 solid hsla(0,0%,100%,.7)}.crop-box[data-v-885bff96]:active:after,.crop-box[data-v-885bff96]:active:before{opacity:1}.crop-box[data-v-885bff96]:before{border-left-width:1px;border-right-width:1px}.crop-box[data-v-885bff96]:after{top:33.3333%;left:0;height:33.3334%;width:100%;border-top-width:1px;border-bottom-width:1px}.crop-box .g-resize[data-v-885bff96]{display:inline-block;z-index:90;position:absolute;bottom:-8px;right:-8px;width:16px;height:16px;cursor:se-resize;border-radius:10px;background-color:#fff;box-shadow:0 2px 4px -2px rgba(0,0,0,.25)}", ""]);

// exports


/***/ }),

/***/ 587:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__vue_core_image_upload_vue__ = __webpack_require__(595);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__vue_core_image_upload_vue___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0__vue_core_image_upload_vue__);

/* harmony default export */ __webpack_exports__["a"] = (__WEBPACK_IMPORTED_MODULE_0__vue_core_image_upload_vue___default.a);


/***/ }),

/***/ 588:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/**
* compress image
* reference https://github.com/brunobar79/J-I-C
**/

/* harmony default export */ __webpack_exports__["default"] = ({
  _getImageType(str) {
    let mimeType = 'image/jpeg';
    const outputType = str.match(/(image\/[\w]+)\.*/)[0];
    if (typeof outputType !== 'undefined'){
      mimeType = outputType;
    }
    return mimeType;
  },

  compress (src, quality, callback) {
    const reader = new FileReader();
    const self = this;
    reader.onload = function(event) {
      let image = new Image();
      image.src = event.target.result;
      image.onload = function() {
        const mimeType = self._getImageType(src.type);
        const cvs = self._getCanvas(image.naturalWidth, image.naturalHeight);
        const ctx = cvs.getContext("2d").drawImage(image, 0, 0);
        const newImageData = cvs.toDataURL(mimeType, quality/100);
        callback(newImageData);
      }
    };
    reader.readAsDataURL(src);
  },
  /**
  * crop image via canvas and generate data
  **/
  crop(image, options, callback) {
    const checkNumber = function(num) {
      return (typeof num === 'number');
    };
    // check crop options
    if(checkNumber(options.toCropImgX) && checkNumber(options.toCropImgY) && options.toCropImgW > 0 && options.toCropImgH > 0) {
      let w = options.toCropImgW;
      let h = options.toCropImgH;
      if(options.maxWidth && options.maxWidth < w) {
        w = options.maxWidth;
        h = options.toCropImgH * w / options.toCropImgW;
      }
      if (options.maxHeight && options.maxHeight < h) {
        h = options.maxHeight
      }
      const cvs = this._getCanvas(w, h);
      const ctx = cvs.getContext('2d').drawImage(image, options.toCropImgX, options.toCropImgY, options.toCropImgW, options.toCropImgH, 0 , 0, w, h);
      const mimeType = this._getImageType(image.src);
      const data = cvs.toDataURL(mimeType, options.compress/100);
      callback(data);
    }
  },

  _loadImage(data, callback) {
    const image = new Image();
    image.src = data;
    image.onload = function () {
      callback(image);
    }
    image.onerror = function() {
      console.log('Error: image error!');
    }
  },

  _getCanvas(width, height) {
    const canvas = document.createElement('canvas');
    canvas.width = width;
    canvas.height = height;
    return canvas;
  },

});


/***/ }),

/***/ 589:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = drag;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__helper__ = __webpack_require__(244);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__helper___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0__helper__);


const isMobile = __WEBPACK_IMPORTED_MODULE_0__helper___default.a.isMobile;
function drag(e, el, coor) {
  if (!el) {
    return;
  }
  const currentX = isMobile ? e.changedTouches[0]['clientX'] : e.clientX;
  const currentY = isMobile ? e.changedTouches[0]['clientY'] : e.clientY;

  let left = currentX - el.parentElement.offsetLeft - document.getElementsByClassName('image-aside')[0].offsetLeft - coor.x;
  let top = currentY - el.parentElement.offsetTop - document.getElementsByClassName('image-aside')[0].offsetTop - coor.y;
  if (left <= 0) {
    left = 0;
  }
  if (left >= coor.maxLeft) {
    left = coor.maxLeft;
  }
  if (top <= 0) {
    top = 0;
  }
  if (top >= coor.maxTop) {
    top = coor.maxTop;
  }
  return {
    left,
    top
  }
};


/***/ }),

/***/ 590:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = resize;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__helper__ = __webpack_require__(244);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__helper___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0__helper__);
/** Reszie
 * @el  dom
 * @container  dom
 * @ratio  string '1:1' like this
 * e events
 **/


const isMobile = __WEBPACK_IMPORTED_MODULE_0__helper___default.a.isMobile;

const W = document.body.offsetWidth;



function resize(e, el, container, coor, ratio) {
  if (!el) {
    return ;
  }
  const H = document.body.offsetHeight;
  const ratioRemainder = 1 / ratio;
  const dotBoxW = parseInt(window.getComputedStyle(container).width);
  const dotBoxH = parseInt(window.getComputedStyle(container).height);
  const $topH = document.querySelector('.info-aside');
  const halfX = (W - dotBoxW) / 2;
  const topH = parseInt(window.getComputedStyle($topH).height);
  const halfY = (H - dotBoxH - topH)/2;
  const resetX = isMobile ? e.changedTouches[0]['clientX'] : e.clientX;
  const resetY = isMobile ? e.changedTouches[0]['clientY'] : e.clientY;
  const elOffsetWidth = parseInt(el.offsetWidth);
  const elOffsetHeight = parseInt(el.offsetHeight);
  const CSSObj = {};
  if (ratio >= 1 && resetX <= halfX + dotBoxW) {
    if (elOffsetWidth >= dotBoxW) {
      CSSObj.width = dotBoxW;
    }
    CSSObj.width = (coor.w + resetX - coor.x);
    CSSObj.height = elOffsetWidth * ratioRemainder;
    if (dotBoxW > dotBoxH) {
      if (elOffsetWidth >= dotBoxH) {
        CSSObj.height = dotBoxH;
        CSSObj.width = dotBoxH * ratio;
      }
    } else if (dotBoxW < dotBoxH) {
      if (elOffsetWidth >= dotBoxW) {
        CSSObj.width = dotBoxW;
        CSSObj.height = dotBoxW * ratioRemainder;
      }
    } else if (elOffsetWidth >= dotBoxW) {
      CSSObj.width = dotBoxW ;
      CSSObj.height = dotBoxW * ratioRemainder;
    }
  } else if (ratio < 1 && resetY < (halfY + dotBoxH + topH)) {
    CSSObj.height = (coor.h + resetY - coor.y);
    CSSObj.width = parseInt(el.style.height) * ratio;
    // 限制拖拉的范围在图片内
    if (dotBoxW > dotBoxH) {
      if (elOffsetHeight >= dotBoxH) {
        CSSObj.height = dotBoxH;
        CSSObj.width = dotBoxH * ratio;
      }
    } else if (dotBoxW < dotBoxH) {
      if (elOffsetWidth >= dotBoxW) {
        CSSObj.width = dotBoxW;
        CSSObj.height = dotBoxW * ratioRemainder;
      }
    } else if (elOffsetWidth >= dotBoxW) {
      CSSObj.width = dotBoxW;
      CSSObj.height = dotBoxW * ratioRemainder;
    }
  } else if(ratio == 'auto' && resetY <= (halfY + dotBoxH + topH) && resetX <= halfY + dotBoxW) {
    CSSObj.height = (coor.h + resetY - coor.y);
    CSSObj.width = (coor.w + resetX - coor.x);
  } else if (resetX <= $halfX + dotBoxW) {
    CSSObj.width = (coor.w + resetX - coor.x);
    CSSObj.height = el.style.width;
    // limit the copr box area
    if (dotBoxW > dotBoxH) {
      if (elOffsetHeight >= dotBoxH) {
        CSSObj.height = dotBoxH;
        CSSObj.width = dotBoxH;
      }
    } else if (dotBoxW < dotBoxH) {
      if (elOffsetWidth >= dotBoxW) {
        CSSObj.width = dotBoxW;
        CSSObj.height = dotBoxW;
      }
    } else if (elOffsetWidth >= dotBoxW) {
      CSSObj.width = el.style.height = dotBoxW;
    }
  }
  return CSSObj;
};


/***/ }),

/***/ 591:
/***/ (function(module, exports) {

/**
 * simple ajax handler
 **/

 //ADD sendAsBinary compatibilty to older browsers
 if (XMLHttpRequest.prototype.sendAsBinary === undefined) {
   XMLHttpRequest.prototype.sendAsBinary = function(string) {
     var bytes = Array.prototype.map.call(string, (function(c) {
         return c.charCodeAt(0) & 0xff;
     }));
     this.send(new Uint8Array(bytes).buffer);
   };
 }

module.exports = function (method, url, headers, data, callback, err, isBinary) {

  const r = new XMLHttpRequest();
  const error = err || function () {
    console.error('AJAX ERROR!');
  };
  const boundary = 'vuecodeimageupload';
  // Binary?
  let binary = false;
  if (method === 'blob') {
    binary = method;
    method = 'GET';
  }
  method = method.toUpperCase();
  // Xhr.responseType 'json' is not supported in any of the vendors yet.
  r.onload = function () {
    let json = r.response;
    try {
      json = JSON.parse(r.responseText);
    } catch (_e) {
      if (r.status === 401) {
        json = error('access_denied', r.statusText);
      }
    }
    let headers = headersToJSON(r.getAllResponseHeaders());
    headers.statusCode = r.status;
    callback(json || (method === 'GET' ? error('empty_response', 'Could not get resource') : {}), headers);
  };
  r.onerror = function () {
    let json = r.responseText;
    try {
      json = JSON.parse(r.responseText);
    } catch (_e) {
      console.error(_e);
    }
    callback(json || error('access_denied', 'Could not get resource'));
  };
  let x;
  // Should we add the query to the URL?
  if (method === 'GET' || method === 'DELETE') {
    data = null;
  } else if (isBinary) {
    const code = data.base64Code.replace('data:' + data.type + ';base64,', '');
    data = ['--' + boundary, 'Content-Disposition: form-data; name="' + data.filed + '"; filename="' + data.filename + '"', 'Content-Type: ' + data.type, '', window.atob(code), '--' + boundary + '--'].join('\r\n');
  }
  // Open the path, async
  r.open(method, url, true);
  if (binary) {
    if ('responseType' in r) {
      r.responseType = binary;
    }
    else {
      r.overrideMimeType('text/plain; charset=x-user-defined');
    }
  }
  // Set any bespoke headers
  if (headers) {
    for (x in headers) {
      r.setRequestHeader(x, headers[x]);
    }
    if (isBinary) {
      r.setRequestHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
    }
  }
  if (isBinary) {
    return r.sendAsBinary(data);
  }
  r.withCredentials = true;
  r.send(data);
  return r;
  // Headers are returned as a string
  function headersToJSON(s) {
    const o = {};
    const reg = /([a-z\-]+):\s?(.*);?/gi;
    let m;
    while (m = reg.exec(s)) {
      o[m[1]] = m[2];
    }
    return o;
  }
};


/***/ }),

/***/ 592:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony default export */ __webpack_exports__["default"] = ({
  url: {
    type: String,
  },
  text: {
    type:String,
    default:  'Upload Image'
  },
  class: {
    type: Array,
    default:function() {
      return [];
    }
  },
  extensions: {
    type: String,
    default:'png.jpg,jpeg,gif,svg,webp'
  },
  inputOfFile: {
    type: String,
    default: 'files'
  },
  crop: {
    type: [String, Boolean],
    default: ''
  },
  cropBtn: {
    type: Object,
    default: function() {
      return {
        ok: 'Ok',
        cancel: 'Cancel',
      }
    }
  },
  cropRatio: {
    type: String,
    default: '1:1'
  },
  maxFileSize:{
    type: Number,
    default: 1024 * 1024 * 100,
  },
  maxWidth:{
    type: Number,
  },
  maxHeight:{
    type: Number,
  },
  inputAccept:{
    type: String,
    default: 'image/jpg,image/jpeg,image/png'
  },
  isXhr: {
    type: Boolean,
    default: true
  },
  headers: {
    type: Object,
    default: function() {
      return {};
    }
  },
  data: {
    type: Object,
    default: function() {
      return {};
    }
  },
  multiple: {
    type: Boolean,
    default: false
  },
  multipleSize: {
    type: Number,
    default: 0
  },
  compress: {
    type: [Number, String],
    default: 0,
  }
});


/***/ }),

/***/ 594:
/***/ (function(module, exports, __webpack_require__) {


/* styles */
__webpack_require__(663)

var Component = __webpack_require__(80)(
  /* script */
  __webpack_require__(250),
  /* template */
  __webpack_require__(637),
  /* scopeId */
  "data-v-885bff96",
  /* cssModules */
  null
)

module.exports = Component.exports


/***/ }),

/***/ 595:
/***/ (function(module, exports, __webpack_require__) {


/* styles */
__webpack_require__(647)

var Component = __webpack_require__(80)(
  /* script */
  __webpack_require__(251),
  /* template */
  __webpack_require__(601),
  /* scopeId */
  null,
  /* cssModules */
  null
)

module.exports = Component.exports


/***/ }),

/***/ 601:
/***/ (function(module, exports) {

module.exports={render:function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "g-core-image-upload-btn"
  }, [_vm._v("\n    " + _vm._s(_vm.text) + "\n    "), _c('form', {
    directives: [{
      name: "show",
      rawName: "v-show",
      value: (!_vm.hasImage),
      expression: "!hasImage"
    }],
    staticClass: "g-core-image-upload-form",
    staticStyle: {
      "display": "block",
      "cursor": "pointer",
      "position": "absolute",
      "left": "0px",
      "top": "0px",
      "width": "1242px",
      "height": "61px",
      "opacity": "0",
      "margin": "0px",
      "padding": "0px",
      "overflow": "hidden"
    },
    attrs: {
      "method": "post",
      "enctype": "multipart/form-data",
      "action": "/api2/common_user/cropHeadUrl"
    }
  }, [_c('input', {
    staticStyle: {
      "width": "100%",
      "height": "100%"
    },
    attrs: {
      "disabled": _vm.uploading,
      "id": 'g-core-upload-input-' + _vm.formID,
      "name": _vm.name,
      "multiple": _vm.multiple,
      "type": "file",
      "accept": _vm.inputAccept
    },
    on: {
      "change": _vm.change
    }
  })]), _vm._v(" "), _c('div', {
    directives: [{
      name: "show",
      rawName: "v-show",
      value: (_vm.hasImage),
      expression: "hasImage"
    }],
    staticClass: "g-core-image-corp-container",
    attrs: {
      "id": 'vciu-modal-' + _vm.formID
    }
  }, [_c('div', {
    staticClass: "image-aside"
  }, [_c('div', {
    staticClass: "g-crop-image-box"
  }, [_c('crop', {
    ref: "cropBox",
    attrs: {
      "form-id": _vm.formID,
      "ratio": _vm.cropRatio
    }
  })], 1)]), _vm._v(" "), _c('div', {
    staticClass: "info-aside"
  }, [_c('p', {
    staticClass: "btn-groups"
  }, [_c('button', {
    staticClass: "btn btn-upload",
    attrs: {
      "type": "button"
    },
    on: {
      "click": _vm.doCrop
    }
  }, [_vm._v(_vm._s(_vm.cropBtn.ok))]), _vm._v(" "), _c('button', {
    staticClass: "btn btn-cancel",
    attrs: {
      "type": "button"
    },
    on: {
      "click": function($event) {
        _vm.cancel()
      }
    }
  }, [_vm._v(_vm._s(_vm.cropBtn.cancel))])])])])])
},staticRenderFns: []}

/***/ }),

/***/ 606:
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
  }), _vm._v(" 表单")]), _vm._v(" "), _c('el-breadcrumb-item', [_vm._v("图片上传")])], 1)], 1), _vm._v(" "), _c('div', {
    staticClass: "content-title"
  }, [_vm._v("支持拖拽")]), _vm._v(" "), _vm._m(0), _vm._v(" "), _c('el-upload', {
    attrs: {
      "action": "/api/posts/",
      "type": "drag",
      "thumbnail-mode": true,
      "on-preview": _vm.handlePreview,
      "on-remove": _vm.handleRemove,
      "on-error": _vm.handleError,
      "default-file-list": _vm.fileList
    }
  }, [_c('i', {
    staticClass: "el-icon-upload"
  }), _vm._v(" "), _c('div', {
    staticClass: "el-dragger__text"
  }, [_vm._v("将文件拖到此处，或"), _c('em', [_vm._v("点击上传")])]), _vm._v(" "), _c('div', {
    staticClass: "el-upload__tip",
    attrs: {
      "slot": "tip"
    },
    slot: "tip"
  }, [_vm._v("只能上传jpg/png文件，且不超过500kb")])]), _vm._v(" "), _c('div', {
    staticClass: "content-title"
  }, [_vm._v("支持裁剪")]), _vm._v(" "), _vm._m(1), _vm._v(" "), _c('img', {
    staticClass: "pre-img",
    attrs: {
      "src": _vm.src,
      "alt": ""
    }
  }), _vm._v(" "), _c('vue-core-image-upload', {
    class: ['pure-button', 'pure-button-primary', 'js-btn-crop'],
    attrs: {
      "crop": true,
      "text": "上传图片",
      "url": "/api/posts/",
      "extensions": "png,gif,jpeg,jpg"
    },
    on: {
      ":imageuploaded": _vm.imageuploaded,
      ":errorhandle": _vm.handleError
    }
  })], 1)
},staticRenderFns: [function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "plugins-tips"
  }, [_vm._v("\n        Element UI自带上传组件。\n        访问地址："), _c('a', {
    attrs: {
      "href": "http://element.eleme.io/#/zh-CN/component/upload",
      "target": "_blank"
    }
  }, [_vm._v("Element UI Upload")])])
},function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "plugins-tips"
  }, [_vm._v("\n        Vue-Core-Image-Upload：一款轻量级的vue上传插件，支持裁剪。\n        访问地址："), _c('a', {
    attrs: {
      "href": "https://github.com/Vanthink-UED/vue-core-image-upload",
      "target": "_blank"
    }
  }, [_vm._v("Vue-Core-Image-Upload")])])
}]}

/***/ }),

/***/ 637:
/***/ (function(module, exports) {

module.exports={render:function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "g-crop-image-principal"
  }, [_c('div', {
    staticClass: "image-wrap",
    style: ({
      width: _vm.width + 'px',
      height: _vm.height + 'px'
    })
  }, [_c('img', {
    ref: "crop-image",
    style: ({
      width: _vm.width + 'px',
      height: _vm.height + 'px'
    }),
    attrs: {
      "src": _vm.src
    }
  })]), _vm._v(" "), _c('div', {
    staticClass: "image-mask"
  }, [_c('div', {
    staticClass: "mask top",
    style: ({
      top: 0,
      height: _vm.cropCSS.top + 'px',
      left: 0,
      width: '100%'
    })
  }), _vm._v(" "), _c('div', {
    staticClass: "mask bottom",
    style: ({
      bottom: 0,
      top: (_vm.cropCSS.top + _vm.cropCSS.height) + 'px',
      left: 0,
      width: '100%'
    })
  }), _vm._v(" "), _c('div', {
    staticClass: "mask left",
    style: ({
      top: _vm.cropCSS.top + 'px',
      height: _vm.cropCSS.height + 'px',
      left: 0,
      width: _vm.cropCSS.left + 'px'
    })
  }), _vm._v(" "), _c('div', {
    staticClass: "mask right",
    style: ({
      top: _vm.cropCSS.top + 'px',
      height: _vm.cropCSS.height + 'px',
      left: (_vm.cropCSS.left + _vm.cropCSS.width) + 'px',
      right: 0
    })
  })]), _vm._v(" "), _c('div', {
    staticClass: "crop-box",
    style: ({
      top: _vm.cropCSS.top + 'px',
      left: _vm.cropCSS.left + 'px',
      height: _vm.cropCSS.height + 'px',
      width: _vm.cropCSS.width + 'px'
    }),
    on: {
      "touchstart": function($event) {
        if ($event.target !== $event.currentTarget) { return null; }
        return _vm.drag($event)
      },
      "mousedown": function($event) {
        if ($event.target !== $event.currentTarget) { return null; }
        return _vm.drag($event)
      }
    }
  }, [_c('div', {
    staticClass: "reference-line v"
  }), _vm._v(" "), _c('div', {
    staticClass: "reference-line h"
  }), _vm._v(" "), _c('a', {
    staticClass: "g-resize",
    on: {
      "touchstart": function($event) {
        if ($event.target !== $event.currentTarget) { return null; }
        return _vm.resize($event)
      },
      "mousedown": function($event) {
        if ($event.target !== $event.currentTarget) { return null; }
        return _vm.resize($event)
      }
    }
  })])])
},staticRenderFns: []}

/***/ }),

/***/ 647:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(301);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
// add the styles to the DOM
var update = __webpack_require__(225)("22b80b59", content, true);

/***/ }),

/***/ 649:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(303);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
// add the styles to the DOM
var update = __webpack_require__(225)("525f6916", content, true);

/***/ }),

/***/ 663:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(317);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
// add the styles to the DOM
var update = __webpack_require__(225)("070304a4", content, true);

/***/ })

});
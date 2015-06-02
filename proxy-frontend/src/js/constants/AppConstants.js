const keyMirror = require('react/lib/keyMirror');

module.exports = {

  SERVER_URL: "http://104.236.138.227:8102",
  ActionTypes: keyMirror({
    ADD_TASK: null,
    UPDATE_ROWSTATUS: null
  }),

  ActionSources: keyMirror({
    SERVER_ACTION: null,
    VIEW_ACTION: null
  })

};

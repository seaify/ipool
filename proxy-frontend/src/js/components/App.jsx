const React = require('react');
const TodoStore = require('../stores/TodoStore');
const ActionCreator = require('../actions/TodoActionCreators');
const TaskList = require('./TaskList.jsx');
const mui = require('material-ui');
const reactbootstrap = require('react-bootstrap');
const Reactable = require('./reactable.jsx');
//const Reactable = require('reactable');
const request = require('request');
const jquery = require('jquery');
const _ = require('lodash');

//var Table = Reactable.Table;
let {Td, Table, Tr} = Reactable;
//for material-ui
let {DropDownIcon, Toolbar, ToolbarGroup, Tabs, Tab, Checkbox, RadioButton, RadioButtonGroup, Toggle, Slider, Menu, LeftNav, MenuItem, ActionGrade, IconButton, DropDownMenu, Dialog, DatePicker, RaisedButton, FlatButton, FontIcon, FloatingActionButton} = mui;

//for bootstrap
let {Input, ModalTrigger, Navbar, Nav, NavItem, TabbedArea, TabPane, Popover, ButtonToolbar, OverlayTrigger, Tooltip, Panel, Modal, ButtonGroup, DropdownButton, ButtonToolbar, Button} = reactbootstrap;

var proxies = [
  { proxy: 'http://110.77.228.161:3128', banned: 1, banned_time: 1223, succ_ratio: 0.7, succ: 70, total: 100 },
  { proxy: 'http://110.77.228.161:12', banned: 0, banned_time: 134534, succ_ratio: 0.8, succ: 80, total: 100 },
  { proxy: 'http://110.78.228.161:678', banned: 1, banned_time: 1344, succ_ratio: 0.6, succ: 60, total: 100 },
  { proxy: 'http://110.77.238.161:3128', banned: 0, banned_time: 3200, succ_ratio: 0.5, succ: 50, total: 100 },
  ];

var proxies_domain = [
  { proxy: 'http://110.77.228.161:3128', domain: 'zillow.com', succ_ratio: 0.7, succ: 70, total: 100 },
  { proxy: 'http://110.77.228.161:12', domain: 'zillow.com', succ_ratio: 0.8, succ: 80, total: 100 },
  { proxy: 'http://110.78.228.161:678', domain: 'zillow.com', succ_ratio: 0.6, succ: 60, total: 100 },
  { proxy: 'http://110.77.238.161:3128', domain: 'zillow.com', succ_ratio: 0.5, succ: 50, total: 100 },
  ];

const LoginModal = React.createClass({
  render() {
    return (
      <Modal {...this.props} bsStyle='primary' title='登录' animation={false}>
        <div className='modal-body'>
        <Input type='email' label='Email Address'  />
        <Input type='password' label='Password' />
        </div>
        <div className='modal-footer'>
          <Button onClick={this.props.onRequestHide}>提交</Button>
          <Button onClick={this.props.onRequestHide}>关闭</Button>
        </div>
      </Modal>
    );
  }
});


const UrlInputModal = React.createClass({
  render() {
    return (
      <Modal {...this.props} bsStyle='primary' title='导入代理url' animation={false}>
        <div className='modal-body'>
         <Input type='text' label='代理url' />
        </div>
        <div className='modal-footer'>
          <Button onClick={this.props.onRequestHide}>提交</Button>
          <Button onClick={this.props.onRequestHide}>关闭</Button>
        </div>
      </Modal>
    );
  }
});


const FileInputModal = React.createClass({
  render() {
    return (
      <Modal {...this.props} bsStyle='primary' title='导入代理文件' animation={false}>
        <div className='modal-body'>
         <Input type='file' label='File' />
        </div>
        <div className='modal-footer'>
          <Button onClick={this.props.onRequestHide}>提交</Button>
          <Button onClick={this.props.onRequestHide}>关闭</Button>
        </div>
      </Modal>
    );
  }
});


let App = React.createClass({


  getInitialState() {
    return {
      proxies: [],
      proxies_domain: []
    }
  },

  _onChange() {
    this.setState(TodoStore.getAll());
  },

  componentDidMount() {
    console.log(this.state);
    console.log(this);
    var self = this;
    //self.setState({'proxies': proxies});
    //self.setState({'proxies_domain': proxies_domain});
    jquery.ajax({
      url: "http://proxy.seaify.com/proxys",
      dataType: "jsonp",
      success: function(data){
        console.log(self);
        if (self.isMounted()) {

          console.log(data['data'][0]);
          self.setState({'proxies': data['data']});
          console.log(self.state);
        }

      }});

    jquery.ajax({
      url: "http://proxy.seaify.com/proxy_domains",
      dataType: "jsonp",
      success: function(data){
        console.log(self);
        if (self.isMounted()) {

          console.log(data['data'][0]);
          self.setState({'proxies_domain': data['data']});
          console.log(self.state);
        }

      }});


    TodoStore.addChangeListener(this._onChange);
  },

  componentWillUnmount() {
    TodoStore.removeChangeListener(this._onChange);
  },

  handleAddNewClick(e) {
    let title = prompt('Enter task title:');
    if (title) {
      ActionCreator.addItem(title);
    }
  },

  handleClearListClick(e) {
    ActionCreator.clearList();
  },

  saveTags: function () {
    console.log('tags: ', this.refs.tags.getTags().join(', '));
  },

  render() {
    let {tasks} = this.state;
    return (
      <div>
        <Navbar brand='React-Bootstrap'>
        <Nav>
          <DropdownButton eventKey={3} title='导入代理'>
            <MenuItem eventKey='1'>
              <ModalTrigger modal={<FileInputModal />}>
                <Button>导入代理文件</Button>                
              </ModalTrigger>
            </MenuItem>
            <MenuItem eventKey='2'>
              <ModalTrigger modal={<UrlInputModal />}>
                <Button>导入代理url</Button>                
              </ModalTrigger>
            </MenuItem>
          </DropdownButton>
          <NavItem>
            <ModalTrigger modal={<LoginModal />}>
                <Button>登录</Button>                
              </ModalTrigger>
          </NavItem>
        </Nav>
      </Navbar>


    <TabbedArea defaultActiveKey={2}>
      <TabPane eventKey={1} tab='代理按domain'>
        <Table className="table table-striped table-bordered table-hover" selectedRows={[0,3,4]} checkbox={true} filterable={['proxy', 'domain']} sortable={true} data={this.state.proxies_domain} itemsPerPage={50} >

          </Table>
        <ButtonToolbar>
          <Button>启用</Button>
          <Button>禁用</Button>
          <Button>删除</Button>
        </ButtonToolbar>
      </TabPane>
      <TabPane eventKey={2} tab='代理禁用表'>
        <Table className="table table-striped table-bordered table-hover" selectedRows={[0,3,4]} checkbox={true} filterable={['proxy', 'domain']} sortable={true} data={this.state.proxies} itemsPerPage={50} />
        <ButtonToolbar>
          <Button>启用</Button>
          <Button>禁用</Button>
          <Button>删除</Button>
        </ButtonToolbar>
      </TabPane>
    </TabbedArea>

        </div>

    );
  }

});

module.exports = App;

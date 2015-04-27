const React = require('react/addons');
const App = require('./components/App.jsx');


var data = [
  {Name: "my love", age: 16},
  {Name: "love2", age: 18},
  {Name: "love3", age: 34}
];


React.render(
  //<QRCode value="https://www.baidu.com/" />,
  //<Video from='youtube' videoId={'z5e7kWSHWTg'} />,
  <App />,
  document.getElementById('table'));


/*
React.renderComponent(
  <Table className="table" data={[
        { name: 'Row one', content: 'These are regular data rows' },
        { name: 'Row two', content: 'They work like above' },
    ]} >
    <Tr className="special-row"
        data={{ name: 'Other Row' , content: 'This is a different row' }} />
  </Table>,
  document.getElementById('table')
);
*/

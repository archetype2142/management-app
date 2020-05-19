import React, { Component } from 'react';
// import Navbar from "../global_components/Navbar";
import SmoothScroll from 'smooth-scroll';

class MainView extends Component {
  constructor() {
    super()
  }
  
  componentDidMount() {
    console.log("main view loaded");
  }

  render() {
    return(
      <div>
        <Navbar/>
        <div className="container">
         <div className="columns">
           <div className="column">
             <h1 className="title is-1">  </h1>
           </div>
           <div className="column">
              <h1 className="title is-1">  </h1>
           </div>
         </div>
        </div>
      </div>
    )
  }
}

export default MainView;
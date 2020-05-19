import React from 'react';

function Navbar() {
  function handleLogout(e) {
    e.preventDefault();
    var xhr = new XMLHttpRequest()

    // get a callback when the server responds
    xhr.addEventListener('load', () => {
      // update the state of the component with the result here
      window.location.replace(window.location.href);
    })
    // open the request with the verb and the url
    xhr.open('GET', window.location.href + 'api/v1/auth/sign_out')
    // send the request
    xhr.send()
  }
  
  return(
    <nav className="level">
      <p className="level-item has-text-centered">
        <a href={window.location.href + "products"} className="link is-info">Products</a>
      </p>
      <p className="level-item has-text-centered">
        <a className="link is-info">Menu</a>
      </p>
      <p className="level-item has-text-centered">
        <span className="title is-1">Management</span>
      </p>
      <p className="level-item has-text-centered">
        <a className="link is-info">Reservations</a>
      </p>
      <p className="level-item has-text-centered">
        <a onClick={handleLogout} className="link is-danger">Log Out</a>
      </p>
    </nav>
  )
}

export default Navbar;

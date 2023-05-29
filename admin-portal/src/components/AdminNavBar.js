import React from "react";
import "./AdminNavBar.css";
// import logo from "../img/logo.png";
import { NavLink, Link } from "react-router-dom";

function AdminNavBar() {
    const handleClick = () => {
        localStorage.removeItem("token");
        localStorage.removeItem("name");
    };
	return (
		<header>
			<div className='menubar'>

				<nav>
					<ul>
						<li>
							<NavLink exact to='/account'>Account</NavLink>
						</li>

						<li>
							<NavLink exact to='/orders'>Orders</NavLink>
						</li>

						<li>
							<NavLink exact to='/menue'>Menu Items</NavLink>
						</li>
					</ul>
				</nav>
                <NavLink className="logout" onClick={handleClick} exact to='/'>Logout</NavLink>
			</div>
		</header>
	);
}

export default AdminNavBar;

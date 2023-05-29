import React, { useState, useContext, useEffect } from "react";
import Modal from "react-modal";
import AdminNavBar from "./AdminNavBar";
import './MenueItems.css';

import { useHistory } from 'react-router-dom';

import LoadingSpinner from "./Loading";
import AuthContext from "./authContext";

import axios from "axios";


function MenueItems() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");

    const [trigger, setTrigger] = useState(false);

    const [name, setName] = useState("");
    const [price, setPrice] = useState(0);
    const [description, setDescription] = useState("");

    const handleNameChange = (event) => {
        setName(event.target.value);
    };

    const handlePriceChange = (event) => {
        setPrice(event.target.value);
    };

    const handleDescriptionChange = (event) => {
        setDescription(event.target.value);
    };

    const history = useHistory();

    const {authKey, setAuthKey, endpoint, username, setUsername} = useContext(AuthContext);

    if (!authKey) {
        setAuthKey(localStorage.getItem("token"))
    }

    if (!username) {
        setUsername(localStorage.getItem("name"))
    }

    const [data, setData] = useState([]);

    useEffect(() => {
        setLoading(true);

        const headers = {
            "content-type": "application/json",
            "Authorization": authKey
        };
        const graphqlQuery = {
            "operationName": "getMenue",
            "query": `query getMenue($username: String!) {
                getMenue(restaurantUsername: $username) {
                  description
                  id
                  name
                  price
                }
              }
            `,
            "variables": {
                username: username
            }
        };
        
        axios({
        url: endpoint,
        method: 'post',
        headers: headers,
        data: graphqlQuery
        }).then(response => {
            console.log(response)
            if (response.data.errors) {
                setError(response.data.errors[0].message)
            } else {
                setData(response.data.data.getMenue)
            }

        }) .catch(error => {
            if (error.message == "Request failed with status code 401") {
                history.push("/");
            }
            setError(error.message)
        })
        .finally(() => {
            setLoading(false); // Set loading to false after the request is complete (success or error)
        });
    }, [authKey, endpoint, username, trigger]);


    const [isOpen, setIsOpen] = useState(false);

    const handleOpenModal = () => {
        setIsOpen(true);
    };

    const handleCloseModal = () => {
        setIsOpen(false);
    };

    const deleteItem = (id) => {
        setLoading(true);
    
        const headers = {
            "content-type": "application/json",
            "Authorization": authKey
        };
        const graphqlQuery = {
            "operationName": "deleteMenueItem",
            "query": `mutation deleteMenueItem($id: String!) {
                deleteMenueItem(id: $id)
              }`,
            "variables": {
                id: id,
            }
        };
        
        axios({
          url: endpoint,
          method: 'post',
          headers: headers,
          data: graphqlQuery
        }).then(response => {
            console.log(response.data.errors)
            if (response.data.errors) {
                setError(response.data.errors[0].message)
            }else {
                setTrigger((prevTrigger) => !prevTrigger); 
            }
        }) .catch(error => {
            setError(error)
          })
          .finally(() => {
            setLoading(false); // Set loading to false after the request is complete (success or error)
          });
    }

    const handleSubmit = (event) => {
        event.preventDefault();
    
        setLoading(true);
    
        const headers = {
            "content-type": "application/json",
            "Authorization": authKey
        };
        const graphqlQuery = {
            "operationName": "addMenueItem",
            "query": `mutation addMenueItem($description: String, $name: String!, $price: Int!, $username: String!) {
                addMenueItem(input: {description: $description, name: $name, price: $price, restaurantUsername: $username}) {
                  description
                  id
                  name
                  price
                }
              }`,
            "variables": {
                username: username,
                name: name,
                price: price,
                description: description
            }
        };
        
        axios({
          url: endpoint,
          method: 'post',
          headers: headers,
          data: graphqlQuery
        }).then(response => {
            if (response.data.errors) {
                setError(response.data.errors[0].message)
            } else {
                setTrigger((prevTrigger) => !prevTrigger);
                handleCloseModal()
            }
    
        }) .catch(error => {
            setError(error)
          })
          .finally(() => {
            setLoading(false); // Set loading to false after the request is complete (success or error)
          });
      };
    
    return (
      <div>
        <AdminNavBar/>
        { isOpen ? 
        
        loading ? 
            (
                <div className="loadingContainer">
                    <LoadingSpinner />
                </div>
            )
            :
            <Modal
                isOpen={isOpen}
                onRequestClose={handleCloseModal}
                contentLabel="Pop-up Modal"
                className="Modal"
                overlayClassName="Overlay"
            >
               
                
                <h2>Add Menu Item</h2>
                {error ? <p className="error">{error}</p> : null}
                
                <form onSubmit={handleSubmit} className='menueForm'>
                    
                    <input
                        type='text'
                        id='name'
                        placeholder='Enter Item Name'
                        className='textfield'
                        value={name}
                        required
                        onChange={handleNameChange}
                    /> <br/>
                    
                    <input
                        type='number'
                        id='price'
                        placeholder='Enter Price'
                        className='textfield'
                        required
                        value={price}
                        onChange={handlePriceChange}
                    /> <br/>
                    
                    <input
                        type='text'
                        id='description'
                        placeholder='Enter Description'
                        className='textfield'
                        value={description}
                        onChange={handleDescriptionChange}
                    /> <br/>
                    <button
                        type='submit'
                        variant="contained" 
                        size="medium" 
                        className='Login-btn'
                    >
                        Add Item
                    </button>
                </form>
                
                <button onClick={handleCloseModal}>Close</button>
            
            </Modal>
        
        :
        
        <div>
            <div className="header">
                <h1 >Menue Items</h1>
                <button className="button" onClick={handleOpenModal}>Add New Item</button>
            </div>
            <hr/>
            <div className="menueBody">
                { loading ? (
                    <LoadingSpinner/>
                ) : (
                <div className="list">

                    {error ? <p className='error'>{error}</p> : 
                    data && data.length > 0 ? data.map((item) => {
                        return (
                            <div key={item.id} className='listItem'>
                                <div className="logoContainer">
                                    <div className="logo"></div>
                                </div>
                                <div className="information">
                                    <p>Name: {item.name}</p>
                                    <p>Price: {item.price}</p>
                                    <p>Description: {item.description}</p>
                                </div>
                                <div className="deleteContainer">
                                    
                                    <button onClick={() => deleteItem(item.id)}>Delete</button>
                                </div>
                            </div>
                        )
                    })
                    : <p>Empty</p>
                    }
                 </div>
                )}
            </div>
        </div>
        }
    
      </div>
    );
  }
  
export default MenueItems
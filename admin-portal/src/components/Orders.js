import React, { useState, useContext, useEffect } from "react";
import Modal from "react-modal";
import AdminNavBar from "./AdminNavBar";
import Order from "./Order";
import './MenueItems.css';

import { useHistory } from 'react-router-dom';

import LoadingSpinner from "./Loading";
import AuthContext from "./authContext";

import axios from "axios";


function Orders() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");

    const [trigger, setTrigger] = useState(false);

    const [customerName, setCustomerName] = useState("");
    const [customerPhone, setCustomerPhone] = useState("");

    const handleCustomerNameChange = (event) => {
        setCustomerName(event.target.value);
    };

    const handleCustomerPhoneChange = (event) => {
        setCustomerPhone(event.target.value);
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
            "operationName": "listOrder",
            "query": `query listOrder($username: String!) {
                listOrder(filter: {restaurantUsername: $username}) {
                  customer_name
                  customer_phone
                  order_date
                  id
                  order_status
                  restaurant_username
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
                setData(response.data.data.listOrder)
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
            "operationName": "createOrder",
            "query": `mutation createOrder($customerName: String!, $customerPhone: String!, $username: String!) {
                createOrder(input: {customerName: $customerName, customerPhone: $customerPhone, restaurantUsername: $username}){
                    id
                    order_date
                    order_status
                    restaurant_username
                    customer_phone
                    customer_name
                  }
              }`,
            "variables": {
                customerName: customerName,
                customerPhone: customerPhone,
                username: username
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
                        id='customerName'
                        placeholder='Enter Customer Name'
                        className='textfield'
                        value={customerName}
                        required
                        onChange={handleCustomerNameChange}
                    /> <br/>
                    
                    <input
                        type='text'
                        id='customerPhone'
                        placeholder='Enter Customer Phone'
                        className='textfield'
                        value={customerPhone}
                        onChange={handleCustomerPhoneChange}
                    /> <br/>
                    <button
                        type='submit'
                        variant="contained" 
                        size="medium" 
                        className='Login-btn'
                    >
                        Create Order
                    </button>
                </form>
                
                <button onClick={handleCloseModal}>Close</button>
            
            </Modal>
        
        :
        
        <div>
            <div className="header">
                <h1 >Orders</h1>
                <button className="button" onClick={handleOpenModal}>Create New Order</button>
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
                            <Order key={item.id} data={item}/>
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
  
export default Orders
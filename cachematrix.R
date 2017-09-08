## Put comments here that give an overall description of what your functions do:




## A pair of functions that are used to create a matrix, caches it, and returns the inverse values.
## Makes sense caching the value, and looked up when needed, rather than computing it again and again.

## The function makeCacheMatrix() creates a matrix

makeCacheMatrix <- function(x = matrix()) {
    mat <- NULL
    set <- function(y) {
        x <<- y
        mat <<- NULL
    }
    get <- function() x
    setmatrix <- function(matrix) mat <<- matrix
    getmatrix <- function() mat
    list(set = set,
         get = get,
         setmatrix = setmatrix,
         getmatrix = getmatrix)
}

## Caching the Inverse of the Matrix returned above.
## If the is already cached, it retrieves the inverse from cache.

cacheSolve <- function(x, ...) {
    ## Returns x matrix inverse
    mat <- x$getmatrix()
    if (!is.null(mat)) {
        message("getting cached data")
        return(mat)
    }
    data <- x$get()
    mat <- solve(data, ...)
    x$setmatrix(mat)
    mat
}




# ----------- Below is the Functions test:


> x <- makeCacheMatrix(matrix(c(3, 1, 4, 2), 2, 2))
> x$get()
     [,1] [,2]
[1,]    3    4
[2,]    1    2
> x$getmatrix()
NULL
> cacheSolve(x)
     [,1] [,2]
[1,]  1.0 -2.0
[2,] -0.5  1.5
> cacheSolve(x)
getting cached data
     [,1] [,2]
[1,]  1.0 -2.0
[2,] -0.5  1.5
> 

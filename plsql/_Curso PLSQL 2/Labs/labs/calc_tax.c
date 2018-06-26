calc_tax(n)

int n;

{

int tax;

tax = (n*8)/100;

return(tax);

}



main()

{

int tot_ord;

printf("Enter the Order Total ");

scanf("%d",&tot_ord);

printf("\n%d", calc_tax(tot_ord));

printf("\n\n");

}

